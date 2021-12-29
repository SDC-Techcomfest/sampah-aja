import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sampah_aja/components/commons/appbar.dart';
import 'package:sampah_aja/components/discover_item.dart';

import '../components/feed_item.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientAppbar(
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
                      onTap: (){}
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

            ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return  const FeedItem(
                      title: 'Jangan Buang Sampah Sembarangan Kalau Tidak Mau Kena Penyakit Ini!',
                      description: 'Kebiasaan buang sampah sembarangan bukan hanya bisa membahayakan kesehatan lingkungan seperti adanya bahaya banjir',
                      imageUrl: 'https://cdn.hellosehat.com/wp-content/uploads/2018/11/Jangan-Buang-Sampah-Sembarangan-Kalau-Tidak-Mau-Kena-Penyakit-Ini.jpg');
                })
          ],
        ),
      ),
    );
  }
}
