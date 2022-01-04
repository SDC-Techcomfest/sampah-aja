import 'package:badges/badges.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';

import '../utils/formz.dart';
import '../utils/routes.dart';
import '../utils/app_theme.dart';
import '../cubit/scanner_cubit.dart';
import '../components/commons/appbar.dart';
import '../components/commons/button.dart';
import '../utils/helpers/camera_helper.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _cameraHelper = CameraHelper();
    return BlocProvider(
        create: (_) => ScannerCubit(cameraUtils: _cameraHelper),
      child: const _ScannerView(),
    );
  }
}

class _ScannerView extends StatelessWidget {
  const _ScannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScannerCubit, ScannerState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Vibration.vibrate(duration: 200);
        }
      },
      child: BlocBuilder<ScannerCubit, ScannerState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  const _CameraScannerView(),
                  Positioned(
                      top: 0,
                      child: TransparentAppbar(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              AppBarButton(
                                onTap: () => Navigator.pop(context),
                                icon: Icons.arrow_back,
                              )
                            ],
                          ),
                        ),
                      )
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const _WasteCountView(),
                            const _ScannerButton(),

                            AppBarButton(
                                icon: Icons.verified,
                                onTap: () {
                                  List<List<String>> images = [state.composeImage, state.reusableImage];
                                  Navigator.pushNamed(
                                      context,
                                      Routes.cartScreen,
                                    arguments: ScreenArguments<List<List<String>>>(images)
                                  );
                                }
                            ),
                          ],
                        ),
                      )
                  )
                ],
              ),
            );
          }
      ),
    );
  }
}

class _CameraScannerView extends StatelessWidget {
  const _CameraScannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ScannerCubit, ScannerState>(
      builder: (context, state) {
        if (state.cameraStatus == CameraStatus.ready) {
          final controller = context.read<ScannerCubit>().getController();
          return CameraPreview(controller);
        } else if (state.cameraStatus == CameraStatus.failure) {
          return const Text('Gagal memuat kamera');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class _ScannerButton extends StatelessWidget {
  const _ScannerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerCubit, ScannerState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.read<ScannerCubit>().takePicture(),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(32.0)
            ),
            child: Center(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    color: AppTheme.colorPrimary,
                    borderRadius: BorderRadius.circular(32.0)
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

class _WasteCountView extends StatelessWidget {
  const _WasteCountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerCubit, ScannerState>(
      builder: (context, state) {
        return Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(32.0)
          ),
          child: Center(
            child: Badge(
              animationType: BadgeAnimationType.slide,
                position: BadgePosition.topEnd(top: 10, end: 10),
                badgeContent: Text(
                  (state.composeImage.length+state.reusableImage.length).toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                child:
                IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {})
            ),
          ),
        );
      }
    );
  }
}





