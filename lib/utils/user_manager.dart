import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static Future<void> setGuest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isGuest', true);
  }

  static Future<bool?> getGuest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isGuest = prefs.getBool('isGuest');
    return isGuest;
  }
}