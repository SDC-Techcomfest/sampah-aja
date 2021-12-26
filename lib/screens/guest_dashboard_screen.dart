import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class GuestDashboardScreen extends StatelessWidget {
  const GuestDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Image.asset('assets/images/guest_dashboard.png', height: 256.0),
                  const SizedBox(height: 50,)
                ],
              ),
              Positioned(
                bottom: 0,
                  width: size.width - 50,
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: _guestMenu(icon: Icons.history, title: 'History', onTap: (){})),
                        Expanded(child: _guestMenu(icon: Icons.history, title: 'History', onTap: (){})),
                        Expanded(child: _guestMenu(icon: Icons.history, title: 'History', onTap: (){})),
                      ],
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _guestMenu({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.colorSecondary,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.colorPrimary),
            Text(title, textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}

