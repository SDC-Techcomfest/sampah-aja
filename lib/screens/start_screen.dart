import 'package:flutter/material.dart';

import '../utils/user_manager.dart';
import '../components/commons/button.dart';
import '../utils/routes.dart';
import '../utils/constants.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          CommonButton(
              title: 'Masuk sebagai Tamu',
              onTap: () {
                UserManager.setGuest();
                Navigator.pushNamed(context, Routes.guestDashboardScreen);
              }
          ),

          CommonButton(
              title: 'Masuk',
              onTap: () {
                Navigator.pushNamed(context, Routes.loginScreen);
              }
          )

        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 32,),
            Image.asset(
              'assets/images/login_illustration.png',
              fit: BoxFit.fill,
              width: size.width,
              height: size.height * 0.4,
            ),

            const SizedBox(height: 96.0)
          ],
        ),

        Positioned(
          bottom: 0,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 128, height: 128),
              Text(Constants.appName, style: Theme.of(context).textTheme.headline4,)
            ],
          ),
        ),
      ],
    );
  }
}
