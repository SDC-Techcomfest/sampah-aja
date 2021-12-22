import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sampah_aja/utils/routes.dart';

import '../components/onboarding_item.dart';
import '../utils/app_theme.dart';
import '../cubit/onboarding_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnBoardingCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: const [
              _OnBoardingView(),
              _OnBoardingIndicator(),
            ],
          ),
        ),
        bottomNavigationBar: const _OnBoardingBottomBar(),
      ),
    );
  }
}

class _OnBoardingView extends StatelessWidget {

  const _OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, int>(
      builder: (context, snapshot) {
        switch(snapshot) {
          case 0:
            return const OnBoardingItem(
                assetImage: 'assets/images/onboarding_1.png',
                title: 'Find hundereds of green brands',
                subtitle: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
            );
          case 1:
            return const OnBoardingItem(
                assetImage: 'assets/images/onboarding_2.png',
                title: 'Find hundereds of green brands',
                subtitle: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
            );
          case 2:
            return const OnBoardingItem(
                assetImage: 'assets/images/onboarding_3.png',
                title: 'Find hundereds of green brands',
                subtitle: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
            );
          default:
            return Container();
        }
      }
    );
  }
}

class _OnBoardingIndicator extends StatelessWidget {
  const _OnBoardingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, int>(
        builder: (context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _dotIndicator(0, snapshot),
              _dotIndicator(1, snapshot),
              _dotIndicator(2, snapshot),
            ],
          );
        }
    );
  }

  Widget _dotIndicator(int position, int now) {
    if (position == now) {
      return Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.colorPrimary),
      );
    } else {
      return Container(
        width: 8,
        height: 8,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.colorSecondary),
      );
    }
  }
}

class _OnBoardingBottomBar extends StatelessWidget {
  const _OnBoardingBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, int>(
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              snapshot == 0 ? const SizedBox(height: 2,width: 2,) :
                TextButton(
                    onPressed: () => context.read<OnBoardingCubit>().decrement(),
                    child: const Text('Sebelumnya')
                ) ,

              TextButton(
                  onPressed: () {
                    if (snapshot == 3) {
                      Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false);
                    } else {
                      context.read<OnBoardingCubit>().increment();
                    }
                  },
                  child: Text(snapshot == 2 ? 'Login' : 'Selanjutnya')
              )
            ],
          ),
        );
      }
    );
  }
}

