import 'package:flutter/material.dart';

import '../components/commons/button.dart';
import '../utils/routes.dart';
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
      children: [
        const _LoginHeader(),
        const SizedBox(height: 24,),
        const _LoginEmailInput(),
        const SizedBox(height: 16,),
        const _LoginPasswordInput(),
        const SizedBox(height: 16,),
        const _LoginButton(),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sudah memiliki akun ? '),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.loginScreen),
              child: const Text('Daftar'),
            )
          ],
        )
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

class _LoginEmailInput extends StatelessWidget {
  const _LoginEmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        onChanged: (String value) {},
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0)
          ),
          hintText: 'Email',
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}

class _LoginPasswordInput extends StatelessWidget {
  const _LoginPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        onChanged: (String value) {},
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0)
          ),
          hintText: 'Password',
        ),
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}



class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CommonButton(
          title: 'Login',
          onTap: () {}
      ),
    );
  }
}





