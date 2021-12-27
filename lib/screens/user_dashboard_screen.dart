import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../components/feed_item.dart';
import '../models/feed_model.dart';
import '../utils/app_theme.dart';

final dummyFeeds = [
  FeedModel(
      title: 'Timbunan sampah meningkat di daerah Surabaya!',
      imageUrl: 'https://akcdn.detik.net.id/community/media/visual/2021/06/24/tumpukan-sampah-berserakan-di-labuhanbatu-1.jpeg'
  )
];

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          _buildHeader(),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              initialChildSize: .6,
                minChildSize: .6,
                maxChildSize: 1,
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(29),
                        topRight: Radius.circular(29)
                      )
                    ),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        const SizedBox(height: 18.0),
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
                            itemCount: dummyFeeds.length,
                            itemBuilder: (context, index) {
                              return FeedItem(
                                  title: dummyFeeds[index].title!,
                                  imageUrl: dummyFeeds[index].imageUrl!);
                            }
                        )
                      ],
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5EB842),
              Color(0xFF40882A)
            ])
      ),
      child: Column(
        children: [
          const Text('Selamat Datang',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold
              ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          const Text(
              'Bantu masyarakat untuk kebersihan lingkungan',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w300
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDashboardMenu(Icons.person),
              const SizedBox(width: 10.0),
              _buildDashboardMenu(Icons.notifications),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDashboardMenu(IconData icon) {
    return Container(
      width: 68,
      height: 50,
      child: Center(
        child: Icon(icon, color: AppTheme.colorPrimary),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppTheme.colorSecondary
      ),
    );
  }
}
