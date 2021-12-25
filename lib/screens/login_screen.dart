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
          // TODO()
        }
      },
      child: Column(
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
      ),
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





