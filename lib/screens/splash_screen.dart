import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      //Navigator.of(context).pushNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              child: SvgPicture.asset('assets/images/splash_background.svg')
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 10.0,),
                const Text(Constants.appName)
              ],
            ),
          )
        ],
      ),
    );
  }
}
