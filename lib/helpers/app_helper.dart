import 'package:flutter/foundation.dart';

class AppHelper {
  static void log(String methodName, String message) {
    debugPrint("{$methodName} {$message}");
  }
}