import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sampah_aja/models/fertilizer_store_model.dart';
import 'package:sampah_aja/utils/app_theme.dart';

import '../cubit/fertilizer_store_cubit.dart';
import '../components/commons/appbar.dart';
import '../components/commons/button.dart';

class FertilizerStoreScreen extends StatelessWidget {
  const FertilizerStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FertilizerStoreCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            const _FertilizerStoreMap(),
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

class _FertilizerStoreMap extends StatefulWidget {
  const _FertilizerStoreMap({Key? key}) : super(key: key);

  @override
  State<_FertilizerStoreMap> createState() => _FertilizerStoreMapState();
}

class _FertilizerStoreMapState extends State<_FertilizerStoreMap> {

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FertilizerStoreCubit, FertilizerStoreState>(
      listener: (context, state) {
        if (state.position != null && state.fertilizerStore != null) {
          _setMarker(state.fertilizerStore!, context);
        }
      },
      child: BlocBuilder<FertilizerStoreCubit, FertilizerStoreState>(
        builder: (context, state) {
          if (state.position != null && state.fertilizerStore != null) {
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

  void _setMarker(List<FertilizerStoreModel> list, BuildContext context) {
    for (var e in list) {
      _markers.add(Marker(
          markerId: MarkerId("${e.position!.latitude}"),
          position: LatLng(e.position!.latitude, e.position!.longitude),
          onTap: () {
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (ctx) {
                  return _FertilizerStoreDetail(fertilizerStoreModel: e);
                });
          }
      ));
    }
    setState(() {});
  }
}

class _FertilizerStoreDetail extends StatelessWidget {
  const _FertilizerStoreDetail({Key? key, required this.fertilizerStoreModel}) : super(key: key);

  final FertilizerStoreModel fertilizerStoreModel;

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
                        color: Color(0xFFDBEBD5),
                        borderRadius: BorderRadius.circular(24.0)
                      ),
                      child: const Center(
                        child: Icon(Icons.storefront_outlined, color: AppTheme.colorPrimary, size: 40.0),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(fertilizerStoreModel.name!, style: theme.textTheme.headline5,),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(fertilizerStoreModel.address!, style: theme.textTheme.bodyText2, textAlign: TextAlign.center,),
                    const SizedBox(
                      height: 24,
                    ),
                    CommonButton(title: 'WhatsApp', onTap: () {})
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


