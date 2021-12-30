import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/commons/dialog.dart';
import '../utils/routes.dart';
import '../utils/formz.dart';
import '../cubit/user_dashboard_cubit.dart';
import '../components/commons/appbar.dart';
import '../components/discover_item.dart';
import '../components/feed_item.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => UserDashboardCubit(),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: _UserDashboardScreen(),
      ),
    );
  }
}

class _UserDashboardScreen extends StatelessWidget {
  const _UserDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    return BlocListener<UserDashboardCubit, UserDashboardState>(
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
                      title: 'Profile',
                      icon: Icons.person,
                      onTap: (){}
                  ),

                  DiscoverItem(
                      title: 'Notification',
                      icon: Icons.notifications,
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
                            onYes: () => context.read<UserDashboardCubit>().logout(),
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

            const _UserDashboardFeed()
          ],
        ),
      ),
    );
  }
}

class _UserDashboardFeed extends StatelessWidget {
  const _UserDashboardFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDashboardCubit, UserDashboardState>(
        builder: (context, state) {
          if (state.listFeed != null) {
            return ListView.builder(
                itemCount: state.listFeed!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          Routes.feedDetailScreen,
                          arguments: ScreenArguments<String>(state.listFeed![index].id!)
                      );
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




