import 'dart:io';

import 'package:final_project/common/services/camera_service.dart';
import 'package:final_project/common/services/ml_service.dart';
import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/features/domain/entities/user/user.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/face_recognition/widgets/sign_up_sheet.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaptureButton extends StatefulWidget {
  const CaptureButton({
    super.key,
    required this.onPressed,
    required this.isAttendance,
    required this.isUpdate,
    required this.reload,
  });
  final Function onPressed;
  final bool isAttendance;
  final bool isUpdate;
  final Function reload;

  @override
  State<CaptureButton> createState() => _CaptureButtonState();
}

class _CaptureButtonState extends State<CaptureButton> {
  final _mlService = locator<MLService>();
  final _storageService = locator<SecureStorageService>();
  final _cameraService = locator<CameraService>();

  late Map<String, dynamic> _registerForm;

  User? predictedUser;

  bool _isBottomSheetVisible = false;

  Future<void> _getRegisterForm() async {
    !widget.isAttendance
        ? !widget.isUpdate
            ? _registerForm = await _storageService.getRegisterData()
            : _registerForm = {}
        : null;
  }

  Future<User?> _predictUser({required User user}) async {
    User? result = await _mlService.predict(user: user);
    return result;
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: widget.isAttendance && predictedUser != null
              ? Text(
                  'Welcome back, ${predictedUser!.name}.',
                  style: const TextStyle(fontSize: 20),
                )
              : widget.isAttendance && predictedUser == null
                  ? const Text(
                      'User not found 😞',
                      style: TextStyle(fontSize: 20),
                    )
                  : Container(),
        );
      },
    ).then((value) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.route,
        (route) => false,
      );
    });
  }

  Future _onAttendancePressed({User? currentUser}) async {
    try {
      bool faceDetected = await widget.onPressed();
      if (faceDetected) {
        if (currentUser != null) {
          var user = await _predictUser(user: currentUser);
          predictedUser = user;
        }
        if (mounted) {
          _showLoginDialog();
        } else {
          widget.reload();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future _onSaveToCloud({String userId = ''}) async {
    try {
      bool faceDetected = await widget.onPressed();
      if (faceDetected) {
        if (mounted) {
          setState(() {
            _isBottomSheetVisible = true;
          });
          final bottomSheetC = Scaffold.of(context).showBottomSheet((context) =>
              SignUpSheetWidget(
                  userId: userId,
                  isUpdate: widget.isUpdate,
                  image: File(_cameraService.imagePath!),
                  predictedData: _mlService.predictedData,
                  registerForm: _registerForm,
                  storageService: _storageService));
          bottomSheetC.closed.whenComplete(() {
            widget.reload();
            setState(() {
              _isBottomSheetVisible = false;
            });
          });
        } else {
          widget.reload();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _getRegisterForm();
  }

  @override
  Widget build(BuildContext context) {
    return _isBottomSheetVisible
        ? const SizedBox.shrink()
        : BlocBuilder<UserCloudBloc, UserCloudState>(builder: (context, state) {
            if (state is GetUserByIdResult && state.isSuccess) {
              final data = state.user;
              return IconButton(
                onPressed: () {
                  if (widget.isUpdate) {
                    _onSaveToCloud(userId: data?.uid ?? "-");
                  } else {
                    _onAttendancePressed(currentUser: data);
                  }
                },
                icon: const Icon(
                  Icons.radio_button_checked,
                  color: Colors.white,
                  size: 60,
                ),
              );
            }
            return IconButton(
              onPressed: () => _onSaveToCloud(),
              icon: const Icon(
                Icons.radio_button_checked,
                color: Colors.white,
                size: 60,
              ),
            );
          });
  }
}
