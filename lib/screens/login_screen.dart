import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_cubit.dart';
import '../components/commons/button.dart';
import '../utils/routes.dart';
import '../utils/constants.dart';
import '../utils/formz.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: const Scaffold(
        body: _LoginView(),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }

        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.userDashboardScreen, (route) => false);
        }
      },
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
          _LoginEmailInput(),
          const SizedBox(height: 10.0),
          _LoginPasswordInput(),
          const SizedBox(height: 120.0),
          _LoginButton()
        ],
      ),
    );
  }
}

class _LoginEmailInput extends StatelessWidget {
  const _LoginEmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0)
              ),
              hintText: 'Email',
              errorText: state.email.invalid ? 'invalid email' : null,
            ),
            keyboardType: TextInputType.emailAddress,
          );
        }
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
      child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextField(
          onChanged: (password) =>
          context.read<LoginCubit>().passwordChanged(password),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0)
              ),
              hintText: 'Password',
              errorText: state.password.invalid ? 'invalid password' : null,
            ),
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
          );
        }
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
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, snapshot) {
          return snapshot.status.isSubmissionInProgress ?
          const Center(child: CircularProgressIndicator()) :
          CommonButton(
              title: 'Login',
              onTap: () => context.read<LoginCubit>().submit()
          );
        }
      ),
    );
  }
}





