import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/app_theme.dart';
import '../components/auth_card.dart';
import '../components/commons/appbar.dart';
import '../cubit/login_cubit.dart';
import '../components/commons/button.dart';
import '../utils/routes.dart';
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
    final size = MediaQuery.of(context).size;
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
      child: Container(
        height: size.height,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0, 0.6),
                colors: [
                  Color(0xFF499D2F).withOpacity(0.2),
                  Colors.white
                ]
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TransparentAppbar(
                  child: Container()
              ),
              const SizedBox(height: 20,),
              AuthCard(
                  child: Column(
                    children: [
                      Text("Let's Sign You In", style: theme.textTheme.headline5),
                      const SizedBox(height: 8),
                      Text("Welcome back, you’ve", style: theme.textTheme.bodyText2),
                      const SizedBox(height: 24),
                      _LoginEmailInput(),
                      const SizedBox(height: 16),
                      _LoginPasswordInput(),
                      const SizedBox(height: 24),
                      _LoginButton(),
                      const SizedBox(height: 16),
                      SecondaryButton(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.loginGuestScreen);
                          },
                          child: Text(
                            'Masuk sebagai tamu',
                            style: theme.textTheme.button!.copyWith(
                              color: AppTheme.colorPrimary
                            )
                          )
                      )
                    ],
                  )
              ),
              const SizedBox(height: 56),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont’s have an account ? ', style: theme.textTheme.bodyText2),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.registerScreen),
                    child: Text('Signup', style: theme.textTheme.bodyText2!.copyWith(
                        color: AppTheme.colorPrimary
                    )),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

class _LoginEmailInput extends StatelessWidget {
  const _LoginEmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          decoration: InputDecoration(
            border: AppTheme.outlineInputBorder(),
            enabledBorder: AppTheme.outlineInputBorder(),
            labelText: 'Email',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
          keyboardType: TextInputType.emailAddress,
        );
      }
    );
  }
}

class _LoginPasswordInput extends StatelessWidget {
  const _LoginPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
        onChanged: (password) =>
        context.read<LoginCubit>().passwordChanged(password),
          decoration: InputDecoration(
            border: AppTheme.outlineInputBorder(),
            enabledBorder: AppTheme.outlineInputBorder(),
            labelText: 'Password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
        );
      }
    );
  }
}



class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, snapshot) {
        return snapshot.status.isSubmissionInProgress ?
        const Center(child: CircularProgressIndicator()) :
        CommonButton(
            title: 'Masuk',
            onTap: () => context.read<LoginCubit>().submit()
        );
      }
    );
  }
}





