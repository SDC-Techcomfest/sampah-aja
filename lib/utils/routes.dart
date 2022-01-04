import 'package:flutter/material.dart';
import '../screens/screens.dart';

class Routes {

  static const String splashScreen = "/splash";
  static const String onBoardingScreen = "/boarding";
  static const String loginScreen = "/login";
  static const String loginGuestScreen = "/login/guest";
  static const String registerScreen = "/register";
  static const String completeProfileScreen = "/complete-profile";
  static const String guestDashboardScreen = "/guest/dashboard";
  static const String userDashboardScreen = "/user/dashboard";
  static const String userProfileScreen = "/user/profile";
  static const String userNotificationScreen = "/user/notification";
  static const String feedDetailScreen = "/feed/detail";
  static const String scannerScreen = "/scanner";
  static const String fertilizerStoreScreen = "/fertilizer";
  static const String cartScreen = "/cart";
  static const String collectorMapScreen = "/collector-map";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case loginGuestScreen:
        return MaterialPageRoute(builder: (_) => const LoginGuestScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case completeProfileScreen:
        return MaterialPageRoute(builder: (_) => const CompleteProfileScreen());
      case guestDashboardScreen:
        return MaterialPageRoute(builder: (_) => const GuestDashboardScreen());
      case userDashboardScreen:
        return MaterialPageRoute(builder: (_) => const UserDashboardScreen());
      case userProfileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case userNotificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case feedDetailScreen:
        final args = settings.arguments as ScreenArguments<String>;
        return MaterialPageRoute(builder: (_) => FeedDetailScreen(id: args.data));
      case fertilizerStoreScreen:
        return MaterialPageRoute(builder: (_) => const FertilizerStoreScreen());
      case scannerScreen:
        return MaterialPageRoute(builder: (_) => const ScannerScreen());
      case cartScreen:
        final args = settings.arguments as ScreenArguments<List<List<String>>>;
        return MaterialPageRoute(builder: (_) => CartScreen(args: args.data));
      case collectorMapScreen:
        final args = settings.arguments as ScreenArguments<Map<String, dynamic>>;
        return MaterialPageRoute(builder: (_) => CollectorMapScreen(
            garbageCollector: args.data['garbageCollector'],
          garbageSize: args.data['garbageSize'],
        ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}

class ScreenArguments<T> {
  final T data;

  ScreenArguments(this.data);
}