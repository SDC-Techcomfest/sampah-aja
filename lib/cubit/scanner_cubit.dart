import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tflite/tflite.dart';

import '../utils/helpers/camera_helper.dart';

enum CameraStatus {ready, failure, initial}

class ScannerState extends Equatable {

  final CameraStatus cameraStatus;

  final List<String> composeImage;
  final List<String> reusableImage;

  const ScannerState({
    this.composeImage = const <String>[],
    this.reusableImage = const <String>[],
    this.cameraStatus = CameraStatus.initial
  });

  @override
  List<Object?> get props => [composeImage, reusableImage, cameraStatus];

  ScannerState copyWith({
    List<String>? composeImage,
    List<String>? reusableImage,
    CameraStatus? cameraStatus
  }) {
    return ScannerState(
        composeImage: composeImage ?? this.composeImage,
        reusableImage: reusableImage ?? this.reusableImage,
        cameraStatus: cameraStatus ?? this.cameraStatus
    );
  }
}

class ScannerCubit extends Cubit<ScannerState> {
  final CameraHelper cameraUtils;
  final ResolutionPreset resolutionPreset;
  final CameraLensDirection cameraLensDirection;

  ScannerCubit({
    required this.cameraUtils,
    this.resolutionPreset = ResolutionPreset.high,
    this.cameraLensDirection = CameraLensDirection.back
  }) : super(const ScannerState()) {
    initializeCamera();
    loadTensorflowModel();
  }

  late CameraController _controller;

  CameraController getController() => _controller;

  bool isInitialized() => _controller.value.isInitialized;

  Future<void> initializeCamera() async {
    try {
      _controller = await cameraUtils
          .getCameraController(resolutionPreset, cameraLensDirection);
      await _controller.initialize();
      emit(state.copyWith(cameraStatus: CameraStatus.ready));
    } on CameraException {
      _controller.dispose();
      emit(state.copyWith(cameraStatus: CameraStatus.failure));
    } catch (error) {
      emit(state.copyWith(cameraStatus: CameraStatus.failure));
    }
  }

  Future<void> loadTensorflowModel() async {
    await Tflite.loadModel(
      model: "assets/converted_model.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> takePicture() async {
    try {
      final imageCapture = await _controller.takePicture();
      await analyzeImage(imageCapture.path);
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<void> analyzeImage(String image) async {
    try {
      var output = await Tflite.runModelOnImage(
        path: image,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      if (output!.isNotEmpty) {
        if (output.first['label'] == 'Organic') {
          emit(state.copyWith(
            composeImage: List.of(state.composeImage)..add(image)
          ));
        } else {
          emit(state.copyWith(
              reusableImage: List.of(state.reusableImage)..add(image)
          ));
        }
      }

    } catch(e) {
      print(e);
      throw Exception(e);
    }
  }
}