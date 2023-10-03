import 'dart:io';

import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/auth/login/login_page.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpSheetWidget extends StatefulWidget {
  final bool isUpdate;
  final List predictedData;
  final File image;
  final SecureStorageService storageService;
  final Map<String, dynamic> registerForm;
  final String userId;

  const SignUpSheetWidget(
      {super.key,
      required this.predictedData,
      required this.registerForm,
      required this.storageService,
      required this.image,
      required this.isUpdate, this.userId = ''});

  @override
  State<SignUpSheetWidget> createState() => _SignUpSheetWidgetState();
}

class _SignUpSheetWidgetState extends State<SignUpSheetWidget> {
  String _imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MultiBlocListener(
            listeners: [
              BlocListener<UserCloudBloc, UserCloudState>(
                listener: (context, state) {
                  if (state is GetPhotoProfileURLResult && state.isSuccess) {
                    setState(() {
                      _imageUrl = state.url;
                    });
                    if (widget.isUpdate) {
                      context.read<UserCloudBloc>().add(UpdatePhotoProfileEvent(
                          uid: widget.userId,
                          imageUrl: _imageUrl,
                          imageData: widget.predictedData));
                    } else {
                      context.read<AuthBloc>().add(RegisterEvent(
                          email: widget.registerForm["email"],
                          password: widget.registerForm["password"],
                          userName: widget.registerForm["name"],
                          role: widget.registerForm["role"]));
                    }
                  } else if (state is GetPhotoProfileURLResult &&
                      !state.isSuccess) {
                    context.showErrorSnackBar(message: state.message);
                    Navigator.pop(context);
                  }
                },
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is RegisterResult && state.isSuccess) {
                    final user = state.user;
                    context.read<UserCloudBloc>().add(InsertUserEvent(
                          uid: user?.uid ?? "-",
                          email: widget.registerForm["email"],
                          userName: widget.registerForm["name"],
                          role: widget.registerForm["role"]
                              .toString()
                              .toLowerCase(),
                          imageData: widget.predictedData,
                          imageUrl: _imageUrl,
                        ));
                  } else if (state is RegisterResult && !state.isSuccess) {
                    context.showErrorSnackBar(message: state.message);
                    Navigator.pop(context);
                  }
                },
              ),
              BlocListener<UserCloudBloc, UserCloudState>(
                listener: (context, state) {
                  if (state is InsertUserResult && state.isSuccess) {
                    context.showSnackBar(
                        message: 'User Data inserted!',
                        backgroundColor: Colors.green);
                    widget.storageService.deleteRegisterData();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginPage.route,
                      (route) => false,
                    );
                  } else if (state is InsertUserResult && !state.isSuccess) {
                    context.showErrorSnackBar(message: state.message);
                    Navigator.pop(context);
                  }
                  if (state is UpdatePhotoProfileResult && state.isSuccess) {
                    context.showSnackBar(
                        message: 'Your photo profile has been updated!',
                        backgroundColor: Colors.green);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      HomePage.route,
                      (route) => false,
                    );
                  } else if (state is UpdatePhotoProfileResult && !state.isSuccess) {
                    context.showErrorSnackBar(message: state.message);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
            child: OutlinedButton(
              onPressed: () async {
                context.read<UserCloudBloc>().add(GetPhotoProfileURLEvent(
                      file: widget.image,
                    ));
              },
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
