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
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Row(
          children: [
            Flexible(
              flex: 8,
              child: Column(
                children: [
                  Text(title, style: theme.textTheme.bodyText1!.copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6.0),
                  Text(subtitle, style: theme.textTheme.bodyText2)
                ],
              ),
            ),
            Flexible(
              flex: 2,
                child: _buildTime(time)
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTime(String time) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(time, style: const TextStyle(fontSize: 12, color: AppTheme.colorPrimary)),
        decoration: BoxDecoration(
          color: AppTheme.colorSecondary,
          borderRadius: BorderRadius.circular(16.0)
        ),
      ),
    );
  }
}
