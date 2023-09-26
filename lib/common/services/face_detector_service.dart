import 'dart:io';

import 'package:camera/camera.dart';
import 'package:final_project/common/services/camera_service.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorService {
  final CameraService _cameraService = locator<CameraService>();

  late FaceDetector _faceDetector;
  FaceDetector get faceDetector => _faceDetector;

  List<Face> _faces = [];
  List<Face> get faces => _faces;
  bool get faceDetected => _faces.isNotEmpty;

  void initialize() {
    // _faceDetector = FaceDetector(
    //   FaceDetectorOptions(
    //     performanceMode: FaceDetectorMode.accurate,
    //   ),
    // );

    _faceDetector = FaceDetector(
        options: FaceDetectorOptions(
            performanceMode: FaceDetectorMode.fast,
            enableContours: true,
            enableClassification: true));
  }

  // Future<void> detectFacesFromImage(CameraImage image) async {
  //   InputImageData firebaseImageMetadata = InputImageData(
  //     imageRotation:
  //         _cameraService.cameraRotation ?? InputImageRotation.rotation0deg,

  //     // inputImageFormat: InputImageFormat.yuv_420_888,

  //     inputImageFormat: InputImageFormatValue.fromRawValue(image.format.raw)
  //         // InputImageFormatMethods.fromRawValue(image.format.raw) for new version
  //         ??
  //         InputImageFormat.yuv_420_888,
  //     size: Size(image.width.toDouble(), image.height.toDouble()),
  //     planeData: image.planes.map(
  //       (Plane plane) {
  //         return InputImagePlaneMetadata(
  //           bytesPerRow: plane.bytesPerRow,
  //           height: plane.height,
  //           width: plane.width,
  //         );
  //       },
  //     ).toList(),
  //   );

  //   // for mlkit 13
  //   final WriteBuffer allBytes = WriteBuffer();
  //   for (final Plane plane in image.planes) {
  //     allBytes.putUint8List(plane.bytes);
  //   }
  //   final bytes = allBytes.done().buffer.asUint8List();

  //   InputImage firebaseVisionImage = InputImage.fromBytes(
  //     // bytes: image.planes[0].bytes,
  //     bytes: bytes,
  //     metadata: firebaseImageMetadata,
  //   );
  //   // for mlkit 13

  //   _faces = await _faceDetector.processImage(firebaseVisionImage);
  // }

  // Future<List<Face>> detect(CameraImage image, InputImageRotation rotation) {
  //   final faceDetector = FaceDetector(
  //     options: FaceDetectorOptions(
  //       performanceMode: FaceDetectorMode.accurate,
  //       enableLandmarks: true,
  //     ),
  //   );
  //   final WriteBuffer allBytes = WriteBuffer();
  //   for (final Plane plane in image.planes) {
  //     allBytes.putUint8List(plane.bytes);
  //   }
  //   final bytes = allBytes.done().buffer.asUint8List();

  //   final Size imageSize =
  //       Size(image.width.toDouble(), image.height.toDouble());
  //   final inputImageFormat =
  //       InputImageFormatValue.fromRawValue(image.format.raw) ??
  //           InputImageFormat.yuv_420_888;

  //   final planeData = image.planes.map(
  //     (Plane plane) {
  //       return InputImagePlaneMetadata(
  //         bytesPerRow: plane.bytesPerRow,
  //         height: plane.height,
  //         width: plane.width,
  //       );
  //     },
  //   ).toList();

  //   final inputImageData = InputImageData(
  //     size: imageSize,
  //     imageRotation: rotation,
  //     inputImageFormat: inputImageFormat,
  //     planeData: planeData,
  //   );

  //   return faceDetector.processImage(
  //     InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData),
  //   );
  // }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  ///for new version
  Future<void> detectFacesFromImage(CameraImage image) async {
    final camera = _cameraService.cameras[-1];
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation = _orientations[
          _cameraService.cameraController!.value.deviceOrientation];
      if (rotationCompensation == null) return;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return;

    if (image.planes.length != 1) return;
    final plane = image.planes.first;

    final firebaseVisionImage = InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
    _faces = await _faceDetector.processImage(firebaseVisionImage);
  }

  dispose() {
    _faceDetector.close();
  }
}
