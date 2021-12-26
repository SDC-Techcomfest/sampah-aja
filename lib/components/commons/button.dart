import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key, this.width, this.height, required this.title, required this.onTap}) : super(key: key);

  final double? width;
  final double? height;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? size.width,
        height: height ?? 56.0,
        decoration: BoxDecoration(
          color: AppTheme.colorPrimary,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child: Text(
            title,
            style: theme.textTheme.button,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
