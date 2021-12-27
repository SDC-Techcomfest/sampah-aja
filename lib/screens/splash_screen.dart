import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/user_manager.dart';
import '../utils/routes.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    _isGuest().then((value) => {
      if (value != null) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.guestDashboardScreen, (route) => false)
      } else if (_isLoggedIn()) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.userDashboardScreen, (route) => false)
      } else {
        Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false)
      }
    });
  }

  bool _isLoggedIn() => FirebaseAuth.instance.currentUser != null;

  Future<bool?> _isGuest() => UserManager.getGuest();

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              child: Image.asset('assets/images/splash_background.png')
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 10.0,),
                const Text(Constants.appName, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
