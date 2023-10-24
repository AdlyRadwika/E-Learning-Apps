import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:final_project/common/services/camera_service.dart';
import 'package:final_project/common/services/face_detector_service.dart';
import 'package:final_project/common/services/ml_service.dart';
import 'package:final_project/features/presentation/pages/face_recognition/widgets/capture_button.dart';
import 'package:final_project/features/presentation/pages/face_recognition/widgets/camera_header.dart';
import 'package:final_project/features/presentation/pages/face_recognition/widgets/face_painter.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FaceRecognitionV2Page extends StatefulWidget {
  static const route = '/face-recognition-v2';

  const FaceRecognitionV2Page(
      {Key? key, this.isAttendance = false, this.isUpdate = false, required this.classCode})
      : super(key: key);

  final bool isAttendance;
  final bool isUpdate;
  final String classCode;

  @override
  FaceRecognitionV2PageState createState() => FaceRecognitionV2PageState();
}

class FaceRecognitionV2PageState extends State<FaceRecognitionV2Page> {
  String? imagePath;

  bool _detectingFaces = false;
  bool pictureTaken = false;

  bool _initializing = false;

  bool _saving = false;

  // service injection
  final FaceDetectorService _faceDetectorService =
      locator<FaceDetectorService>();
  final CameraService _cameraService = locator<CameraService>();
  final MLService _mlService = locator<MLService>();

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    super.dispose();

    _cameraService.dispose();
    _faceDetectorService.dispose();
  }

  _start() async {
    setState(() => _initializing = true);
    await _cameraService.initialize();
    await _mlService.initialize();
    _faceDetectorService.initialize();
    setState(() => _initializing = false);

    _frameFaces();
  }

  Future<bool> onShot() async {
    if (!_faceDetectorService.faceDetected) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('No face detected!'),
          );
        },
      );

      return false;
    } else {
      _saving = true;
      await Future.delayed(const Duration(milliseconds: 500));
      XFile? file = await _cameraService.takePicture();
      imagePath = file?.path;

      setState(() {
        pictureTaken = true;
      });

      return true;
    }
  }

  _frameFaces() {
    _cameraService.cameraController?.startImageStream((image) async {
      if (_cameraService.cameraController != null) {
        if (_detectingFaces) return;

        _detectingFaces = true;

        try {
          await _faceDetectorService.detectFacesFromImage(image);

          if (_faceDetectorService.faceDetected) {
            var faceDetected = _faceDetectorService.faces[0];
            if (_saving) {
              _mlService.setCurrentPrediction(image, faceDetected);
              setState(() {
                _saving = false;
              });
            }
          } else {
            if (kDebugMode) {
              print('face is null');
            }
            _faceDetectorService.faces = [];
          }

          _detectingFaces = false;
        } catch (e, stacktrace) {
          if (kDebugMode) {
            print('Error _faceDetectorService face => $e');
            print('Error _faceDetectorService stacktrace => $stacktrace');
          }
          _detectingFaces = false;
        }
      }
    });
  }

  _onBackPressed() {
    Navigator.pop(context);
  }

  _reload() {
    setState(() {
      pictureTaken = false;
    });
    _start();
  }

  @override
  Widget build(BuildContext context) {
    const double mirror = math.pi;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    late Widget body;
    if (_initializing) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!_initializing && pictureTaken) {
      body = SizedBox(
        width: width,
        height: height,
        child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(mirror),
            child: FittedBox(
                fit: BoxFit.cover,
                child: imagePath?.trim().isNotEmpty == true
                    ? Image.file(File(imagePath!))
                    : Container(
                        color: Colors.black,
                      ))),
      );
    }

    if (!_initializing && !pictureTaken) {
      body = Transform.scale(
        scale: 1.0,
        child: AspectRatio(
          aspectRatio: MediaQuery.of(context).size.aspectRatio,
          child: OverflowBox(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: SizedBox(
                width: width,
                height:
                    width * _cameraService.cameraController!.value.aspectRatio,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CameraPreview(_cameraService.cameraController!),
                    CustomPaint(
                      painter:
                          FacePainter(screenWidth: width, screenHeight: height),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
        body: Stack(
          children: [
            body,
            CameraHeader(
              widget.isAttendance
                  ? "Face Recognition"
                  : widget.isUpdate
                      ? "Update Photo Profile"
                      : "Register",
              onBackPressed: _onBackPressed,
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CaptureButton(
          classCode: widget.classCode,
          isUpdate: widget.isUpdate,
          onPressed: onShot,
          isAttendance: widget.isAttendance,
          reload: _reload,
        ));
  }
}
