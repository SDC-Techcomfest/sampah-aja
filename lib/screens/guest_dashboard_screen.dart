import 'package:flutter/material.dart';

import '../models/feed_model.dart';
import '../components/feed_item.dart';
import '../utils/app_theme.dart';

final dummyFeed = [
  FeedModel(
      title: 'Timbunan sampah meningkat di daerah Surabaya!',
      imageUrl: 'https://akcdn.detik.net.id/community/media/visual/2021/06/24/tumpukan-sampah-berserakan-di-labuhanbatu-1.jpeg'
  )
];

class GuestDashboardScreen extends StatelessWidget {
  const GuestDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Image.asset('assets/images/guest_dashboard.png', height: 256.0),
                  const SizedBox(height: 50,)
                ],
              ),
              Positioned(
                bottom: 0,
                  width: size.width - 50,
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: _guestMenu(icon: Icons.history, title: 'History', onTap: (){})),
                        Expanded(child: _guestMenu(icon: Icons.history, title: 'History', onTap: (){})),
                        Expanded(child: _guestMenu(icon: Icons.history, title: 'History', onTap: (){})),
                      ],
                    ),
                  )
              )
            ],
          ),
          ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Image.asset('assets/images/banner_dashboard.ong', width: 327, height: 131),
              const SizedBox(width: 16.0),
              Image.asset('assets/images/banner_dashboard.ong', width: 327, height: 131)
            ],
          ),
          const SizedBox(height: 50.0),
          Text('Artikel Terbaru', style: theme.textTheme.headline5),
          ListView.builder(
            itemCount: dummyFeed.length,
              itemBuilder: (context, index) {
                return FeedItem(
                    title: dummyFeed[index].title!,
                    imageUrl: dummyFeed[index].imageUrl!);
              }
          )
        ],
      ),
    );
  }

  Widget _guestMenu({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.colorSecondary,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.colorPrimary),
            Text(title, textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}



