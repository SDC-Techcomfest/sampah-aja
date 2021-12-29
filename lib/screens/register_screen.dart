import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/auth_card.dart';
import '../components/commons/appbar.dart';
import '../utils/app_theme.dart';
import '../utils/routes.dart';
import '../cubit/register_cubit.dart';
import '../components/commons/button.dart';
import '../utils/formz.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: const Scaffold(
        body: _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return BlocListener<RegisterCubit, RegisterState>(
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
        width: size.width,
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
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AppBarButton(
                        onTap: () => Navigator.pop(context),
                        icon: Icons.arrow_back_ios
                    ),
                  )
              ),
              const SizedBox(height: 20,),
              AuthCard(
                  child: Column(
                    children: [
                      Text("Memulai", style: theme.textTheme.headline5),
                      const SizedBox(height: 8),
                      Text("Daftar akun untuk melanjutkan", style: theme.textTheme.bodyText2),
                      const SizedBox(height: 24),
                      _RegisterFirstNameInput(),
                      const SizedBox(height: 16),
                      _RegisterEmailInput(),
                      const SizedBox(height: 16),
                      _RegisterPasswordInput(),
                      const SizedBox(height: 16),
                      _RegisterConfirmPasswordInput(),
                      const SizedBox(height: 24),
                      _RegisterButton(),
                    ],
                  )
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account ? ', style: theme.textTheme.bodyText2, textAlign: TextAlign.center,),
                  GestureDetector(
                    onTap: () {},
                    child: Text('Sign in', style: theme.textTheme.bodyText2!.copyWith(
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

class _RegisterFirstNameInput extends StatelessWidget {
  const _RegisterFirstNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return TextField(
          onChanged: (String value) =>
              context.read<RegisterCubit>().firstNameChanged(value),
          decoration: InputDecoration(
            border: AppTheme.outlineInputBorder(),
              enabledBorder: AppTheme.outlineInputBorder(),
            labelText: 'Nama',
            errorText: state.firstName.invalid ? 'invalid text': null
          ),
          keyboardType: TextInputType.name,
        );
      }
    );
  }
}

class _RegisterEmailInput extends StatelessWidget {
  const _RegisterEmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return TextField(
          onChanged: (String value) => context.read<RegisterCubit>().emailChanged(value),
          decoration: InputDecoration(
            border: AppTheme.outlineInputBorder(),
              enabledBorder: AppTheme.outlineInputBorder(),
              labelText: 'Email',
              errorText: state.email.invalid ? 'invalid email': null
          ),
          keyboardType: TextInputType.emailAddress,
        );
      }
    );
  }
}

class _RegisterPasswordInput extends StatelessWidget {
  const _RegisterPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return TextField(
          onChanged: (String value) => context.read<RegisterCubit>().passwordChanged(value),
          decoration: InputDecoration(
            border: AppTheme.outlineInputBorder(),
              enabledBorder: AppTheme.outlineInputBorder(),
              labelText: 'Password',
              errorText: state.password.invalid ? 'invalid password': null
          ),
          obscureText: true,
        );
      }
    );
  }
}

class _RegisterConfirmPasswordInput extends StatelessWidget {
  const _RegisterConfirmPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return TextField(
          onChanged: (String value) => context.read<RegisterCubit>().confirmedPasswordChanged(value),
          decoration: InputDecoration(
            border: AppTheme.outlineInputBorder(),
              enabledBorder: AppTheme.outlineInputBorder(),
            labelText: 'Konfirmasi password',
              errorText: state.confirmedPassword.invalid ? 'password no match': null
          ),
          obscureText: true,
        );
      }
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress ? const CircularProgressIndicator()
            : CommonButton(
            title: 'Daftar',
            onTap: () => context.read<RegisterCubit>().submit()
        );
      }
    );
  }
}



