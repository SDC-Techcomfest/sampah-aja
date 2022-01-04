import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/commons/appbar.dart';
import '../components/commons/button.dart';
import '../cubit/collector_map_cubit.dart';
import '../models/user_model.dart';
import '../utils/app_theme.dart';
import '../utils/formz.dart';

class CollectorMapScreen extends StatelessWidget {
  final bool garbageCollector;
  final int garbageSize;
  const CollectorMapScreen({Key? key, required this.garbageCollector, required this.garbageSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CollectorMapCubit(garbageCollector, garbageSize),
      child: Scaffold(
        body: Stack(
          children: [
            const _CollectorMapView(),
            Positioned(
                top: 0,
                child: TransparentAppbar(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        AppBarButton(
                          onTap: () => Navigator.pop(context),
                          icon: Icons.arrow_back,
                        )
                      ],
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

class _CollectorMapView extends StatefulWidget {
  const _CollectorMapView({Key? key}) : super(key: key);

  @override
  State<_CollectorMapView> createState() => _CollectorMapViewState();
}

class _CollectorMapViewState extends State<_CollectorMapView> {

  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollectorMapCubit, CollectorMapState>(
      listener: (context, state) {
        if (state.position != null && state.users != null) {
          _setMarker(state.users!, context);
        }

        if (state.status == FormzStatus.submissionSuccess) {
          Navigator.pop(context);
          Navigator.pop(context, 'success');
        }
      },
      child: BlocBuilder<CollectorMapCubit, CollectorMapState>(
          builder: (context, state) {
            if (state.position != null && state.users != null) {
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(state.position!.latitude, state.position!.longitude),
                    zoom: 14.0
                ),
                markers: _markers,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
      ),
    );
  }

  void _setMarker(List<UserModel> list, BuildContext context) {
    for (var e in list) {
      _markers.add(Marker(
          markerId: MarkerId("${e.position!.latitude}"),
          position: LatLng(e.position!.latitude, e.position!.longitude),
          onTap: () {
            final bloc = BlocProvider.of<CollectorMapCubit>(context);
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return BlocProvider.value(
                    value: bloc,
                      child: _CollectorDetail(userModel: e));
                });
          }
      ));
    }
    setState(() {});
  }
}

class _CollectorDetail extends StatelessWidget {
  const _CollectorDetail({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 384,
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 33,
              ),
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                          color: const Color(0xFFDBEBD5),
                          borderRadius: BorderRadius.circular(24.0)
                      ),
                      child: const Center(
                        child: Icon(Icons.storefront_outlined, color: AppTheme.colorPrimary, size: 40.0),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(userModel.name!, style: theme.textTheme.headline5,),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(userModel.address!, style: theme.textTheme.bodyText2, textAlign: TextAlign.center,),
                    const SizedBox(
                      height: 24,
                    ),
                    _SubmitNotificationButton(id: userModel.id!)
                  ],
                ),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                    color: Colors.white
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/logo2.png'),
          )
        ],
      ),
    );
  }
}

class _SubmitNotificationButton extends StatelessWidget {
  final String id;
  const _SubmitNotificationButton({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectorMapCubit, CollectorMapState>(
        builder: (context, state) {
          return state.status == FormzStatus.submissionInProgress ?
              const Center(child: CircularProgressIndicator()) :
          CommonButton(title: 'Pilih ini', onTap: () {
            context.read<CollectorMapCubit>().sendNotification(id);
          });
        }
    );
  }
}

