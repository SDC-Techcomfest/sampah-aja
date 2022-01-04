import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/routes.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final _firebaseAuth = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (_firebaseAuth != null) {
        if (_firebaseAuth!.isAnonymous) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.guestDashboardScreen, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, Routes.userDashboardScreen, (route) => false);
        }
      } else {
        Navigator.pushNamedAndRemoveUntil(context, Routes.onBoardingScreen, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            colors: [
              Color(0xFFDDEDD8),
              Colors.white
            ]
          )
        ),
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Image.asset('assets/images/splash_background.png')
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/logo.png', width: 128.0, height: 128.0,),
                  const SizedBox(height: 10.0,),
                  Text(Constants.appName, style: Theme.of(context).textTheme.headline4,),
                  const SizedBox(height: 90.0,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
