import 'dart:io';

import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/services/camera_service.dart';
import 'package:final_project/common/services/ml_service.dart';
import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/common/services/uuid_service.dart';
import 'package:final_project/features/domain/entities/attendance/attendance.dart';
import 'package:final_project/features/domain/entities/user/user.dart';
import 'package:final_project/features/presentation/bloc/attendance_cloud/attendance_cloud_bloc.dart';
import 'package:final_project/features/presentation/bloc/attendance_cloud/get_attendance/get_attendance_bloc.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/face_recognition/widgets/sign_up_sheet.dart';
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
    required this.classCode,
  });
  final Function onPressed;
  final bool isAttendance;
  final bool isUpdate;
  final Function reload;
  final String classCode;

  @override
  State<CaptureButton> createState() => _CaptureButtonState();
}

class _CaptureButtonState extends State<CaptureButton> {
  final _mlService = locator<MLService>();
  final _storageService = locator<SecureStorageService>();
  final _cameraService = locator<CameraService>();
  final _uuidService = locator<UuidService>();

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

  void _showResultDialog() {
    final isAttendanceValid = widget.isAttendance && predictedUser != null;
    showDialog(
      context: context,
      barrierDismissible: isAttendanceValid,
      builder: (context) {
        return AlertDialog(
          content: Wrap(
            children: [
              Center(
                child: isAttendanceValid
                    ? Text(
                        'Your attendance has been submitted, ${predictedUser?.name ?? "Unknown"}.',
                        style: const TextStyle(fontSize: 20),
                      )
                    : widget.isAttendance && predictedUser == null
                        ? const Text(
                            'Face is not recognized 😞',
                            style: TextStyle(fontSize: 20),
                          )
                        : TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              widget.reload();
                            },
                            child: const Text('Try Again')),
              ),
            ],
          ),
          actions: [
            isAttendanceValid
                ? BlocListener<AttendanceCloudBloc, AttendanceCloudState>(
                    listener: (context, state) {
                      if (state is InsertAttendanceResult && state.isSuccess) {
                        Navigator.pop(context);
                        context.read<GetAttendancesBloc>().add(
                            GetAttendancesByClassEvent(
                                classCode: widget.classCode));
                      } else if (state is InsertAttendanceResult &&
                          !state.isSuccess) {
                        context.showErrorSnackBar(context,
                            message: state.message);
                      }
                    },
                    child: ElevatedButton(
                        onPressed: () {
                          final data = Attendance(
                              id: _uuidService.generateUuidV4(),
                              label:
                                  "${predictedUser?.name ?? "Unknown"}'s Attendance",
                              studentId: predictedUser?.uid ?? "-",
                              updatedAt: '-',
                              createdAt: DateTime.now().toString(),
                              classCode: widget.classCode);
                          context
                              .read<AttendanceCloudBloc>()
                              .add(InsertAttendanceEvent(data: data));
                        },
                        child: const Text('Confirm')),
                  )
                : TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Confirm')),
          ],
        );
      },
    ).then((value) {
      Navigator.pop(context);
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
          _showResultDialog();
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
                  } else if (widget.isAttendance) {
                    _onAttendancePressed(currentUser: data);
                  } else {
                    _onSaveToCloud(userId: data?.uid ?? "-");
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
