import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/routes.dart';
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
        body: Container(
          padding: const EdgeInsets.all(32.0),
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
          child: const _OnBoardingView(),
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
                title: 'Daur ulang barang',
                subtitle: 'Gunakan lagi barang sisa yang bisa didaur ulang'
            );
          case 1:
            return const OnBoardingItem(
                assetImage: 'assets/images/onboarding_2.png',
                title: 'Berkontribusi kepada lingkungan',
                subtitle: 'Ikut serta dalam menjaga kebersihan lingkungan sekitar'
            );
          case 2:
            return const OnBoardingItem(
                assetImage: 'assets/images/onboarding_3.png',
                title: 'Alam yang asri',
                subtitle: 'Dengan begitu anda akan merasakan keasrian alam'
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
            children: [

                Flexible(
                  flex: 1,
                  child: TextButton(
                      onPressed: () => context.read<OnBoardingCubit>().decrement(),
                      child: const Text('Lewati', style: TextStyle(color: Colors.grey),)
                  ),
                ) ,

              const Flexible(
                flex: 2,
                  child: _OnBoardingIndicator()
              ),

              Flexible(
                child: TextButton(
                    onPressed: () {
                      if (snapshot == 2) {
                        Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false);
                      } else {
                        context.read<OnBoardingCubit>().increment();
                      }
                    },
                    child: Text(snapshot == 2 ? 'Selesai' : 'Lanjut')
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

