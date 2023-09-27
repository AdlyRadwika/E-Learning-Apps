import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/services/ml_service.dart';
import 'package:final_project/features/presentation/pages/face_recognition/db/database_helper.dart';
import 'package:final_project/features/presentation/pages/face_recognition/index_page.dart';
import 'package:final_project/features/presentation/pages/face_recognition/model/user_model.dart';
import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  final TextEditingController _userTextEditingController =
      TextEditingController(text: '');

  final TextEditingController _passwordTextEditingController =
      TextEditingController(text: '');

  User? predictedUser;

  bool _isBottomSheetVisible = false;

  Future _signUp(BuildContext context,
      {required String user, required String password}) async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    List predictedData = _mlService.predictedData;
    User userToSave = User(
      user: user,
      password: password,
      modelData: predictedData,
    );
    //TODO: replace with firebase firestore
    await databaseHelper.insert(userToSave);
  }

  Future<User?> _predictUser() async {
    User? userAndPass = await _mlService.predict();
    return userAndPass;
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: widget.isLogin && predictedUser != null
              ? Text(
                  'Welcome back, ${predictedUser!.user}.',
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
      Navigator.pushReplacementNamed(context, IndexPage.route);
    });
  }

  Future onTap() async {
    try {
      bool faceDetected = await widget.onPressed();
      if (faceDetected) {
        if (widget.isLogin) {
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
          Column(
            children: [
              CustomTextField(
                controller: _userTextEditingController,
                label: "Your Name",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _passwordTextEditingController,
                label: "Password",
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () async {
                  final user = _userTextEditingController.text.trim();
                  final password = _passwordTextEditingController.text.trim();

                  if (user.isEmpty || password.isEmpty) {
                    context.showErrorSnackBar(
                      message: 'Isi username atau password!',
                    );
                  } else {
                    await _signUp(context, user: user, password: password)
                        .then((value) {
                      context.showSnackBar(
                          message: 'Register berhasil!',
                          backgroundColor: Colors.green);
                      Navigator.pushReplacementNamed(context, IndexPage.route);
                    });
                  }
                },
                child: const Text('SIGN UP'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
