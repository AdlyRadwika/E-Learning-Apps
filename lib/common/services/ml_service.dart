import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/common/services/image_converter.dart';
import 'package:final_project/features/presentation/pages/face_recognition/db/database_helper.dart';
import 'package:final_project/features/presentation/pages/face_recognition/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:image/image.dart' as imglib;

class MLService {
  tfl.Interpreter? _interpreter;
  double threshold = 0.5;

  List _predictedData = [];
  List get predictedData => _predictedData;

  Future initialize() async {
    late tfl.Delegate delegate;
    try {
      if (Platform.isAndroid) {
        delegate = tfl.GpuDelegateV2(
          options: tfl.GpuDelegateOptionsV2(
            isPrecisionLossAllowed: false,
            inferencePreference: 0,
            inferencePriority1: 2,
            inferencePriority2: 3,
            inferencePriority3: 0,
          ),
        );
      } else if (Platform.isIOS) {
        delegate = tfl.GpuDelegate(
          options:
              tfl.GpuDelegateOptions(allowPrecisionLoss: true, waitType: 1),
        );
      }
      var interpreterOptions = tfl.InterpreterOptions()..addDelegate(delegate);

      _interpreter = await tfl.Interpreter.fromAsset(AssetConts.tflite,
          options: interpreterOptions);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to load model.');
        print(e);
      }
    }
  }

  void setCurrentPrediction(CameraImage cameraImage, Face? face) {
    if (_interpreter == null) {
      initialize();
    }
    if (face == null) throw Exception('Face is null');
    List input = _preProcess(cameraImage, face);

    input = input.reshape([1, 112, 112, 3]);
    List output = List.generate(1, (index) => List.filled(192, 0));

    _interpreter?.run(input, output);
    output = output.reshape([192]);

    _predictedData = List.from(output);
  }

  Future<User?> predict() async {
    return _searchResult(_predictedData);
  }

  List _preProcess(CameraImage image, Face faceDetected) {
    imglib.Image croppedImage = _cropFace(image, faceDetected);
    imglib.Image img = imglib.copyResizeCropSquare(croppedImage, 112);

    Float32List imageAsList = imageToByteListFloat32(img);
    return imageAsList;
  }

  imglib.Image _cropFace(CameraImage image, Face faceDetected) {
    imglib.Image convertedImage = _convertCameraImage(image);
    double x = faceDetected.boundingBox.left - 10.0;
    double y = faceDetected.boundingBox.top - 10.0;
    double w = faceDetected.boundingBox.width + 10.0;
    double h = faceDetected.boundingBox.height + 10.0;
    return imglib.copyCrop(
        convertedImage, x.round(), y.round(), w.round(), h.round());
  }

  imglib.Image _convertCameraImage(CameraImage image) {
    var img = convertToImage(image);
    var img1 = imglib.copyRotate(img, -90);
    return img1;
  }

  Float32List imageToByteListFloat32(imglib.Image image) {
    var convertedBytes = Float32List(1 * 112 * 112 * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (var i = 0; i < 112; i++) {
      for (var j = 0; j < 112; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (imglib.getRed(pixel) - 128) / 128;
        buffer[pixelIndex++] = (imglib.getGreen(pixel) - 128) / 128;
        buffer[pixelIndex++] = (imglib.getBlue(pixel) - 128) / 128;
      }
    }
    return convertedBytes.buffer.asFloat32List();
  }

  Future<User?> _searchResult(List predictedData) async {
    //TODO: replace with firebase data
    DatabaseHelper dbHelper = DatabaseHelper.instance;

    List<User> users = await dbHelper.queryAllUsers();
    double minDist = 999;
    double currDist = 0.0;
    User? predictedResult;

    for (User u in users) {
      currDist = _euclideanDistance(u.modelData, predictedData);
      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
        predictedResult = u;
      }
    }
    return predictedResult;
  }

  double _euclideanDistance(List? e1, List? e2) {
    if (e1 == null || e2 == null) throw Exception("Null argument");

    double sum = 0.0;
    for (int i = 0; i < e1.length; i++) {
      sum += pow((e1[i] - e2[i]), 2);
    }
    return sqrt(sum);
  }

  void setPredictedData(value) {
    _predictedData = value;
  }

  dispose() {
  }
}
