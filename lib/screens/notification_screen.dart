import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../components/commons/appbar.dart';
import '../components/commons/button.dart';
import '../components/notification_item.dart';
import '../cubit/notification_cubit.dart';
import '../models/notification_model.dart';
import '../utils/app_theme.dart';
import '../utils/utilities.dart';
import '../utils/formz.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            GradientAppbar(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppBarButton(
                          onTap: () => Navigator.pop(context),
                          icon: Icons.arrow_back
                      ),
                      const SizedBox(width: 16.0),
                      Text('Notifikasi', style: Theme.of(context).textTheme.headline6,)
                    ],
                  ),
                ),
              ),
            ),
            const _NotificationView(),
          ],
        ),
      ),
    );
  }
}

class _NotificationView extends StatelessWidget {
  const _NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Gagal menghapus notifikasi'),
              ),
            );
        }
      },
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<NotificationCubit>(context);

          if (state.listNotification.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.listNotification.length,
              itemBuilder: (context, index) {
                return NotificationItem(
                    title: state.listNotification[index].title!,
                    subtitle: state.listNotification[index].address!,
                    time: Utilities.readTimeStamp(
                        state.listNotification[index].time!),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return BlocProvider.value(
                              value: bloc,
                              child: _NotificationDetailSheet(
                                notificationModel: state.listNotification[index],
                              ),
                            );
                          });
                    }
                );
              },
            );

          } else if (state.listNotification.isEmpty) {
            return const Center(
              child: Text('Tidak ada notifikasi'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }

        }
      ),
    );
  }
}


class _NotificationDetailSheet extends StatelessWidget {
  final NotificationModel notificationModel;
  const _NotificationDetailSheet({Key? key, required this.notificationModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Detail Notification',
                textAlign: TextAlign.center,
                style: theme.textTheme.headline6,
              ),
              const Icon(Icons.keyboard_arrow_down_sharp)
            ],
          ),
          const SizedBox(height: 24),
          const Text(
              'Nama',
          ),
          const SizedBox(height: 10),
          Text(notificationModel.from ?? ""),
          const SizedBox(height: 10),
          Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          ),

          const SizedBox(height: 16),
          const Text('Alamat'),
          const SizedBox(height: 10),
          Text(
              notificationModel.address!,
            style: const TextStyle(
              fontSize: 16.0,
              letterSpacing: 0.3
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          ),

          const SizedBox(height: 16),
          const Text('Jumlah Sampah'),
          const SizedBox(height: 10),
          Text(
            notificationModel.garbageSize!.toString(),
            style: const TextStyle(
                fontSize: 16.0,
                letterSpacing: 0.3
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          ),

          const SizedBox(height: 24.0),
          CommonButton(
            title: 'Tandai telah diterima',
            onTap: () {
              context.read<NotificationCubit>().deleteNotification(notificationModel.id!);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
          SecondaryButton(
              onTap: () {
                MapsLauncher.launchCoordinates(
                  notificationModel.position!.latitude,
                    notificationModel.position!.longitude
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Buka di Maps',
                      style: theme.textTheme.button!.copyWith(
                          color: AppTheme.colorPrimary
                      )
                  ),
                  const SizedBox(width: 8.0,),
                  const Icon(Icons.gps_fixed, color: AppTheme.colorPrimary,)
                ],
              )
          )
        ],
      ),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
          color: Colors.white
      ),
    );
  }
}

