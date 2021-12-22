import 'package:flutter/material.dart';

import '../utils/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _LoginHeader()

      ],
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 32,),
            Image.asset(
              'assets/images/login_illustration.png',
              fit: BoxFit.fill,
              width: size.width,
              height: size.height * 0.4,
            ),

             const SizedBox(height: 96.0)
          ],
        ),

        Positioned(
          bottom: 0,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 128, height: 128),
              Text(Constants.appName, style: Theme.of(context).textTheme.headline4,)
            ],
          ),
        ),
      ],
    );
  }
}




