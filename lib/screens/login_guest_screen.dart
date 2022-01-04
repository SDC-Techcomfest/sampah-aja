import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_guest_cubit.dart';
import '../components/commons/appbar.dart';
import '../components/commons/button.dart';
import '../utils/app_theme.dart';
import '../utils/formz.dart';
import '../utils/routes.dart';

class LoginGuestScreen extends StatelessWidget {
  const LoginGuestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginGuestCubit(),
      child: Scaffold(
        body: Column(
          children: [
            GradientAppbar(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppBarButton(
                      onTap: () => Navigator.pop(context),
                      icon: Icons.arrow_back
                  ),
                ),
              ),
            ),
            _LoginGuestView()
          ],
        ),
      ),
    );
  }
}

class _LoginGuestView extends StatelessWidget {
  const _LoginGuestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<LoginGuestCubit, LoginGuestState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.guestDashboardScreen, (route) => false);
        }

        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Gagal mengirimkan form'),
              ),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Text(
              'Masuk sebagai tamu',
              style: theme.textTheme.headline5,
            ),
            const SizedBox(height: 8),
            Text(
              'Isi nama anda supaya lebih mudah dikenali',
              style: theme.textTheme.bodyText2,
            ),
            const SizedBox(height: 40.0),
            _NameInput(),
            const SizedBox(height: 24.0),
            _WhatsappInput(),
            const SizedBox(height: 40.0),
            _SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginGuestCubit, LoginGuestState>(
        buildWhen: (previous, current) => previous.name != current.name,
        builder: (context, state) {
          return TextField(
            onChanged: (value) => context.read<LoginGuestCubit>().nameChanged(value),
            decoration: InputDecoration(
              border: AppTheme.outlineInputBorder(),
              enabledBorder: AppTheme.outlineInputBorder(),
              labelText: 'Nama',
              errorText: state.name.invalid ? 'Nama tidak valid' : null,
            ),
            keyboardType: TextInputType.emailAddress,
          );
        }
    );
  }
}

class _WhatsappInput extends StatelessWidget {
  const _WhatsappInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginGuestCubit, LoginGuestState>(
        buildWhen: (previous, current) => previous.whatsapp != current.whatsapp,
        builder: (context, state) {
          return TextField(
            onChanged: (value) => context.read<LoginGuestCubit>().whatsappChanged(value),
            decoration: InputDecoration(
              border: AppTheme.outlineInputBorder(),
              enabledBorder: AppTheme.outlineInputBorder(),
              labelText: 'Whatsapp',
              errorText: state.whatsapp.invalid ? 'Whatsapp tidak valid' : null,
            ),
            keyboardType: TextInputType.emailAddress,
          );
        }
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginGuestCubit, LoginGuestState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress ?
            const Center(child: CircularProgressIndicator()) :
            CommonButton(
                title: 'Kirimkan',
                onTap: () => context.read<LoginGuestCubit>().submit()
            );
      },
    );
  }
}

