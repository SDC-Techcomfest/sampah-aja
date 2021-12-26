import 'package:flutter/material.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({Key? key, required this.title, required this.imageUrl}) : super(key: key);

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 108.0,
              height: 77.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imageUrl)
                ),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            const SizedBox(width: 8.0),
            Column(
              children: [
                Text(title),
                const SizedBox(width: 8.0),
                TextButton(
                    onPressed: (){},
                    child: const Text('Selengkapnya')
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
