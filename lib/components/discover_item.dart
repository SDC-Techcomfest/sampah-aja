import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class DiscoverItem extends StatelessWidget {
  const DiscoverItem({Key? key, required this.title, required this.icon, required this.onTap}) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: AppTheme.colorPrimary.withOpacity(0.2)
            ),
            child: Center(
              child: Icon(icon, color: AppTheme.colorPrimary ),
            ),
          ),
          const SizedBox(height: 8,),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
