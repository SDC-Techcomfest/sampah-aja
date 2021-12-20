import 'dart:async';

import 'package:camera/camera.dart';
import 'package:sampah_aja/models/result.dart';
import 'package:tflite/tflite.dart';

import 'app_helper.dart';

class TFLiteHelper {

  static StreamController<List<Result>> tfLiteResultsController = StreamController.broadcast();
  static final List<Result> _outputs = [];
  static var modelLoaded = false;

  static Future<String> loadModel() async{
    AppHelper.log("loadModel", "Loading model..");

    String? log = await Tflite.loadModel(
      model: "assets/converted_model.tflite",
      labels: "assets/labels.txt",
    );

    return log ?? "";
  }

  static classifyImage(CameraImage image) async {

    await Tflite.runModelOnFrame(
        bytesList: image.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        numResults: 5)
        .then((value) {
      if (value!.isNotEmpty) {
        AppHelper.log("classifyImage", "Results loaded. ${value.length}");

        //Clear previous results
        _outputs.clear();

        for (var element in value) {
          _outputs.add(Result(
              element['confidence'], element['index'], element['label']));

          AppHelper.log("classifyImage",
              "${element['confidence']} , ${element['index']}, ${element['label']}");
        }
      }

      //Sort results according to most confidence
      _outputs.sort((a, b) => a.confidence.compareTo(b.confidence));

      //Send results
      tfLiteResultsController.add(_outputs);
    });
  }

  static void disposeModel(){
    Tflite.close();
    tfLiteResultsController.close();
  }
}