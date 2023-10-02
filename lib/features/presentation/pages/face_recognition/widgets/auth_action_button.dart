import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/services/ml_service.dart';
import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/features/domain/entities/user/user.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/auth/login/login_page.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthActionButton extends StatefulWidget {
  const AuthActionButton({
    super.key,
    required this.onPressed,
    required this.isLogin,
    required this.reload,
  });
  final Function onPressed;
  final bool isLogin;
  final Function reload;

  @override
  State<AuthActionButton> createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  final MLService _mlService = locator<MLService>();
  final _storageService = locator<SecureStorageService>();

  late Map<String, dynamic> _registerForm;

  User? predictedUser;

  bool _isBottomSheetVisible = false;

  Future<void> _getRegisterForm() async {
    !widget.isLogin
        ? _registerForm = await _storageService.getRegisterData()
        : null;
  }

  Future<User?> _predictUser() async {
    User? userAndPass = await _mlService.predict(
        user: const User(
            name: 'name',
            email: 'email',
            imageUrl: 'imageUrl',
            imageData: ['imageData'],
            role: 'role',
            updatedAt: 'updatedAt',
            createdAt: 'createdAt',
            uid: 'uid'));
    return userAndPass;
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: widget.isLogin && predictedUser != null
              ? Text(
                  'Welcome back, ${predictedUser!.name}.',
                  style: const TextStyle(fontSize: 20),
                )
              : widget.isLogin && predictedUser == null
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

  Future onTap() async {
    try {
      bool faceDetected = await widget.onPressed();
      if (faceDetected) {
        if (widget.isLogin) {
          //FIXME: betulin flownya tinggal kasih object usernya ke ml service
          var user = await _predictUser();
          if (user != null) {
            predictedUser = user;
          }
          //FIXME: jadi navigate ke screen baru karena risiko mounted
          if (mounted) {
            _showLoginDialog();
          } else {
            widget.reload();
          }
        } else {
          if (mounted) {
            setState(() {
              _isBottomSheetVisible = true;
            });
            final bottomSheetC = Scaffold.of(context)
                .showBottomSheet((context) => signUpSheet(context));
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
        : IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.radio_button_checked,
              color: Colors.white,
              size: 60,
            ),
          );
  }

  signUpSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is RegisterResult && state.isSuccess) {
                    final user = state.user;
                    List predictedData = _mlService.predictedData;
                    context.read<UserCloudBloc>().add(InsertUserEvent(
                          uid: user?.uid ?? "-",
                          email: _registerForm["email"],
                          userName: _registerForm["name"],
                          role: _registerForm["role"].toString().toLowerCase(),
                          imageData: predictedData,
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
                    _storageService.deleteRegisterData();
                    _registerForm = {};
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginPage.route,
                      (route) => false,
                    );
                  } else if (state is InsertUserResult && !state.isSuccess) {
                    context.showErrorSnackBar(message: state.message);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
            child: OutlinedButton(
              onPressed: () async {
                context.read<AuthBloc>().add(RegisterEvent(
                    email: _registerForm["email"],
                    password: _registerForm["password"],
                    userName: _registerForm["name"],
                    role: _registerForm["role"]));
              },
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
