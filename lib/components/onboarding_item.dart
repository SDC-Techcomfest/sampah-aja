import 'package:flutter/material.dart';

class OnBoardingItem extends StatelessWidget {

  final String assetImage;
  final String title;
  final String subtitle;

  const OnBoardingItem({
    Key? key,
    required this.assetImage,
    required this.title,
    required this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 64,),
          Image.asset(assetImage, width: 180, height: 180,),
          const SizedBox(height: 24,),
          Text(
            title,
            style: theme.textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16,),
          Text(
            title,
            style: theme.textTheme.bodyText2,
            textAlign: TextAlign.center
          ),
        ],
      ),
    );
  }
}
