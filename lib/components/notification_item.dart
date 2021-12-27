import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.onTap
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Flexible(
            flex: 8,
            child: Column(
              children: [
                Text(title),
                Text(subtitle)
              ],
            ),
          ),
          Flexible(
            flex: 2,
              child: _buildTime(time)
          )
        ],
      ),
    );
  }

  Widget _buildTime(String time) {
    return Container(
      child: Text(time, style: const TextStyle(fontSize: 12, color: AppTheme.colorPrimary)),
      decoration: BoxDecoration(
        color: AppTheme.colorSecondary,
        borderRadius: BorderRadius.circular(8.0)
      ),
    );
  }
}
