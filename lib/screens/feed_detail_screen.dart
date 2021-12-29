import 'package:flutter/material.dart';

import '../components/commons/appbar.dart';
import '../components/commons/button.dart';

class FeedDetailScreen extends StatelessWidget {
  const FeedDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          GradientAppbar(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      AppBarButton(
                          onTap: () => Navigator.pop(context),
                          icon: Icons.arrow_back
                      ),
                      const SizedBox(width: 24,),
                      Text('Feed', style: theme.textTheme.headline6,)
                    ],
                  ),
                ),
              )
          ),

          const _FeedDetailView()
        ],
      ),
    );
  }
}

class _FeedDetailView extends StatelessWidget {
  const _FeedDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            'https://cdn.hellosehat.com/wp-content/uploads/2018/11/Jangan-Buang-Sampah-Sembarangan-Kalau-Tidak-Mau-Kena-Penyakit-Ini.jpg',
            width: size.width,
            height: 221,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Jangan Buang Sampah Sembarangan Kalau Tidak Mau Kena Penyakit Ini!',
                  style: theme.textTheme.headline6,
                ),
                const SizedBox(height: 18,),
                Text(
                  'by Farhan Roy',
                  style: theme.textTheme.bodyText2,
                ),
                const SizedBox(height: 18,),
                Text(
                  'Kebiasaan buang sampah sembarangan bukan hanya bisa membahayakan kesehatan lingkungan seperti adanya bahaya banjir',
                  style: theme.textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

