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

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), (){
      if (_isLoggedIn()) {
        Navigator.of(context).pushNamed('//'); // TODO
      } else {
        Navigator.of(context).pushNamed(Routes.onBoardingScreen);
      }
    });
  }

  bool _isLoggedIn() => FirebaseAuth.instance.currentUser != null;

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
