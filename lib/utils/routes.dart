import 'package:flutter/material.dart';
import '../screens/screens.dart';

class Routes {

  static const String splashScreen = "/splash";
  static const String onBoardingScreen = "/boarding";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
  static const String guestDashboardScreen = "/guest/dashboard";
  static const String userDashboardScreen = "/user/dashboard";
  static const String feedDetailScreen = "/feed/detail";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case guestDashboardScreen:
        return MaterialPageRoute(builder: (_) => const GuestDashboardScreen());
      case userDashboardScreen:
        return MaterialPageRoute(builder: (_) => const UserDashboardScreen());
      case feedDetailScreen:
        return MaterialPageRoute(builder: (_) => const FeedDetailScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}