import 'package:flutter/material.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl
  }) : super(key: key);

  final String title;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      child: Container(
        width: 296,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imageUrl),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(16.0)
              ),
            ),
            const SizedBox(height: 15,),
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8,),
            Text(description,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
