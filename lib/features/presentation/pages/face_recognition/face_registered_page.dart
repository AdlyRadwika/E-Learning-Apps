import 'dart:async';
import 'package:camera/camera.dart';
import 'package:final_project/common/services/camera_service.dart';
import 'package:final_project/common/services/face_detector_service.dart';
import 'package:final_project/common/services/ml_service.dart';
import 'package:final_project/features/presentation/pages/face_recognition/model/user_model.dart';
import 'package:final_project/features/presentation/pages/face_recognition/widgets/auth_button.dart';
import 'package:final_project/features/presentation/pages/face_recognition/widgets/camera_detection_preview.dart';
import 'package:final_project/features/presentation/pages/face_recognition/widgets/camera_header.dart';
import 'package:final_project/features/presentation/pages/face_recognition/widgets/sign_in_form.dart';
import 'package:final_project/features/presentation/pages/face_recognition/widgets/single_picture.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';

class FaceDetectionPage extends StatefulWidget {
  static const route = '/face-detection';

  const FaceDetectionPage({Key? key}) : super(key: key);

  @override
  FaceDetectionPageState createState() => FaceDetectionPageState();
}

class FaceDetectionPageState extends State<FaceDetectionPage> {
  final CameraService _cameraService = locator<CameraService>();
  final FaceDetectorService _faceDetectorService =
      locator<FaceDetectorService>();
  final MLService _mlService = locator<MLService>();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isPictureTaken = false;
  bool _isInitializing = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _mlService.dispose();
    _faceDetectorService.dispose();
    super.dispose();
  }

  Future _start() async {
    setState(() => _isInitializing = true);
    await _cameraService.initialize();
    setState(() => _isInitializing = false);
    _frameFaces();
  }

  _frameFaces() async {
    bool processing = false;
    _cameraService.cameraController!
        .startImageStream((CameraImage image) async {
      if (processing) return; // prevents unnecessary overprocessing.
      processing = true;
      await _predictFacesFromImage(image: image);
      processing = false;
    });
  }

  Future<void> _predictFacesFromImage({required CameraImage image}) async {
    await _faceDetectorService.detectFacesFromImage(image);
    if (_faceDetectorService.faceDetected) {
      _mlService.setCurrentPrediction(image, _faceDetectorService.faces[0]);
    }
    if (mounted) setState(() {});
  }

  Future<void> takePicture() async {
    if (_faceDetectorService.faceDetected) {
      await _cameraService.takePicture();
      setState(() => _isPictureTaken = true);
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              const AlertDialog(content: Text('No face detected!')));
    }
  }

  _onBackPressed() {
    Navigator.of(context).pop();
  }

  _reload() {
    if (mounted) setState(() => _isPictureTaken = false);
    _start();
  }

  Future<void> onTap() async {
    await takePicture();
    if (_faceDetectorService.faceDetected) {
      User? user = await _mlService.predict();
      var bottomSheetController = scaffoldKey.currentState!
          .showBottomSheet((context) => _faceDetectionPageSheet(user: user));
      bottomSheetController.closed.whenComplete(_reload);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header = CameraHeader("LOGIN", onBackPressed: _onBackPressed);
    Widget? fab;
    if (!_isPictureTaken) fab = AuthButton(onTap: onTap);

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          BodyWidget(
            isInitializing: _isInitializing,
            isPictureTaken: _isPictureTaken,
            cameraService: _cameraService,
          ),
          header
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: fab,
    );
  }

  _faceDetectionPageSheet({required User? user}) => user == null
      ? Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: const Text(
            'User not found 😞',
            style: TextStyle(fontSize: 20),
          ),
        )
      : SignInSheet(user: user);
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
    required this.isInitializing,
    required this.isPictureTaken,
    required this.cameraService,
  });

  final bool isInitializing;
  final bool isPictureTaken;
  final CameraService cameraService;

  @override
  Widget build(BuildContext context) {
    if (isInitializing) {
      return const Center(child: CircularProgressIndicator());
    }
    if (isPictureTaken) {
      return SinglePicture(imagePath: cameraService.imagePath!);
    }
    return CameraDetectionPreview();
  }
}
