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

class AppBarButton extends StatelessWidget {
  const AppBarButton({Key? key, required this.onTap, required this.icon}) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: Container(
          width: 56,
          height: 56,
          child: Center(
            child: Icon(icon),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)
          ),
        )
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({Key? key, required this.onTap, required this.child, this.width, this.height, }) : super(key: key);
  final double? width;
  final double? height;
  final VoidCallback onTap;
  final Widget child;
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
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xffE3E6E7)
            )
        ),
        child: Center(
          child: child,
        )
      ),
    );
  }
}


