import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/commons/dialog.dart';
import '../utils/routes.dart';
import '../cubit/guest_dashboard_cubit.dart';
import '../components/commons/appbar.dart';
import '../components/discover_item.dart';
import '../components/feed_item.dart';
import '../utils/formz.dart';

class GuestDashboardScreen extends StatelessWidget {
  const GuestDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GuestDashboardCubit(),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: _GuestDashboardView(),
      ),
    );
  }
}

class _GuestDashboardView extends StatelessWidget {
  const _GuestDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<GuestDashboardCubit, GuestDashboardState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.splashScreen, (route) => false);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GradientAppbar(
                child: Text('Selamat Datang')
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Discover',
                style: theme.textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DiscoverItem(
                      title: 'Scanner',
                      icon: Icons.qr_code,
                      onTap: (){}
                  ),

                  DiscoverItem(
                      title: 'Toko',
                      icon: Icons.storefront_sharp,
                      onTap: (){}
                  ),

                  DiscoverItem(
                      title: 'Keluar',
                      icon: Icons.logout,
                      onTap: () {
                        showDialog(context: context, builder: (ctx) {
                          return ConfirmationDialog(
                            title: 'Apakah anda yakin ?',
                            content: 'Jika anda keluar maka informasi anda akan hilang',
                            onYes: () => context.read<GuestDashboardCubit>().logout(),
                          );
                        });
                      }
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Feed',
                style: theme.textTheme.headline6,
              ),
            ),

            const _GuestDashboardFeed()
          ],
        ),
      ),
    );
  }
}

class _GuestDashboardFeed extends StatelessWidget {
  const _GuestDashboardFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestDashboardCubit, GuestDashboardState>(
        builder: (context, state) {
          if (state.listFeed != null) {
            return ListView.builder(
                itemCount: state.listFeed!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.feedDetailScreen);
                    },
                    child: FeedItem(
                        title: state.listFeed![index].title!,
                        description: state.listFeed![index].description!,
                        imageUrl: state.listFeed![index].imageUrl!,
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}





