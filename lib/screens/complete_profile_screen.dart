import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/commons/appbar.dart';
import '../components/commons/button.dart';
import '../utils/constants.dart';
import '../utils/formz.dart';
import '../cubit/complete_profile_cubit.dart';
import '../utils/app_theme.dart';
import '../utils/routes.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompleteProfileCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            GradientAppbar(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        AppBarButton(
                            onTap: () => Navigator.pop(context),
                            icon: Icons.arrow_back
                        ),
                        const SizedBox(width: 24,),
                        Text('Lengkapi Profil', style: Theme.of(context).textTheme.headline6)
                      ],
                    ),
                  ),
                )
            ),
            const _CompleteProfileView(),
          ],
        ),
      ),
    );
  }
}

class _CompleteProfileView extends StatelessWidget {
  const _CompleteProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {

        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Gagal mengirimkan form')),
            );
        }

        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.userDashboardScreen, (route) => false);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: const [
            _NameInput(),
            SizedBox(height: 16),
            _AddressInput(),
            SizedBox(height: 16),
            _UserTypeInput(),
            SizedBox(height: 16),
            _WhatsappNumberInput(),
            SizedBox(height: 16),
            _SubmitButton()
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
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state) {
        return TextField(
          onChanged: (String value) =>
              context.read<CompleteProfileCubit>().nameChanged(value),
          decoration: InputDecoration(
              border: AppTheme.outlineInputBorder(),
              enabledBorder: AppTheme.outlineInputBorder(),
              labelText: 'Nama',
              errorText: state.name.invalid ? 'invalid text': null
          ),
          keyboardType: TextInputType.name,
        );
      }
    );
  }
}

class _AddressInput extends StatelessWidget {
  const _AddressInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
        builder: (context, state) {
          return TextField(
            onChanged: (String value) =>
                context.read<CompleteProfileCubit>().addressChanged(value),
            decoration: InputDecoration(
                border: AppTheme.outlineInputBorder(),
                enabledBorder: AppTheme.outlineInputBorder(),
                labelText: 'Alamat',
                errorText: state.address.invalid ? 'invalid text': null
            ),
            keyboardType: TextInputType.name,
          );
        }
    );
  }
}

class _UserTypeInput extends StatelessWidget {
  const _UserTypeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
        builder: (context, state) {
          return DropdownButtonFormField(
            value: Constants.userType[0],
            onChanged: (dynamic value) =>
                context.read<CompleteProfileCubit>().userTypeChanged(value),
            decoration: InputDecoration(
                border: AppTheme.outlineInputBorder(),
                enabledBorder: AppTheme.outlineInputBorder(),
                labelText: 'Tipe',
                errorText: state.userType.invalid ? 'invalid type': null
            ),
            items: Constants.userType.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Row(children: <Widget>[Text(item.toString()),]),
              );
            }).toList(),
          );
        }
    );
  }
}

class _WhatsappNumberInput extends StatelessWidget {
  const _WhatsappNumberInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
        builder: (context, state) {
          return TextField(
            onChanged: (String value) =>
                context.read<CompleteProfileCubit>().whatsappNumberChanged(value),
            decoration: InputDecoration(
                border: AppTheme.outlineInputBorder(),
                enabledBorder: AppTheme.outlineInputBorder(),
                labelText: 'Nomor Whatsapp',
                errorText: state.name.invalid ? 'invalid number': null
            ),
            keyboardType: TextInputType.name,
          );
        }
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
        builder: (context, state) {
          return state.status == FormzStatus.submissionInProgress ?
              const Center(child: CircularProgressIndicator()) :
              CommonButton(
                  title: 'Kirim',
                  onTap: () => context.read<CompleteProfileCubit>().submit()
              );
        }
    );
  }
}




