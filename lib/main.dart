import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'utils/app_theme.dart';
import 'utils/constants.dart';
import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: AppTheme.theme(),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.splashScreen,
    );
  }
}