import 'package:flutter/material.dart';
import '../screens/screens.dart';

class Routes {

  static const String splashScreen = "/splash";
  static const String onBoardingScreen = "/boarding";
  static const String loginScreen = "/login";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}