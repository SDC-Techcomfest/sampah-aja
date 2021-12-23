import 'package:flutter/material.dart';

import '../components/commons/button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 48.0),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            child: IconButton(
                onPressed: (){},
                icon: const Icon(Icons.arrow_back_ios)
            ),
          ),
          const SizedBox(height: 16.0),
          Image.asset(
            'assets/images/personal_details.png',
            width: 64.0,
            height: 64.0,
          ),
          Text('Daftar', style: theme.textTheme.headline5),
          const SizedBox(height: 32.0),
          _RegisterFirstNameInput(),
          const SizedBox(height: 10.0),
          _RegisterLastNameInput(),
          const SizedBox(height: 10.0),
          _RegisterEmailInput(),
          const SizedBox(height: 10.0),
          _RegisterPasswordInput(),
          const SizedBox(height: 10.0),
          _RegisterConfirmPasswordInput(),
          const SizedBox(height: 120.0),
          _RegisterButton()
        ],
      ),
    );
  }
}

class _RegisterFirstNameInput extends StatelessWidget {
  const _RegisterFirstNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String value) {},
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0)
        ),
        hintText: 'Nama depan',
      ),
      keyboardType: TextInputType.name,
    );
  }
}

class _RegisterLastNameInput extends StatelessWidget {
  const _RegisterLastNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String value) {},
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0)
        ),
        hintText: 'Nama belakang',
      ),
      keyboardType: TextInputType.name,
    );
  }
}

class _RegisterEmailInput extends StatelessWidget {
  const _RegisterEmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String value) {},
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0)
        ),
        hintText: 'Email',
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class _RegisterPasswordInput extends StatelessWidget {
  const _RegisterPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String value) {},
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0)
        ),
        hintText: 'Password',
      ),
      obscureText: true,
    );
  }
}

class _RegisterConfirmPasswordInput extends StatelessWidget {
  const _RegisterConfirmPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String value) {},
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0)
        ),
        hintText: 'Email',
      ),
      obscureText: true,
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonButton(
        title: 'Daftar',
        onTap: () {}
    );
  }
}



