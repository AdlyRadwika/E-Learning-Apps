import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/services/ml_service.dart';
import 'package:final_project/features/presentation/pages/face_recognition/db/database_helper.dart';
import 'package:final_project/features/presentation/pages/face_recognition/index_page.dart';
import 'package:final_project/features/presentation/pages/face_recognition/model/user_model.dart';
import 'package:final_project/features/presentation/pages/face_recognition/widgets/app_button.dart';
import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';

class AuthActionButton extends StatefulWidget {
  const AuthActionButton(
      {super.key,
      required this.onPressed,
      required this.isLogin,
      required this.reload});
  final Function onPressed;
  final bool isLogin;
  final Function reload;
  @override
  _AuthActionButtonState createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  final MLService _mlService = locator<MLService>();

  final TextEditingController _userTextEditingController =
      TextEditingController(text: '');
  final TextEditingController _passwordTextEditingController =
      TextEditingController(text: '');

  User? predictedUser;

  Future _signUp(BuildContext context) async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    List predictedData = _mlService.predictedData;
    String user = _userTextEditingController.text;
    String password = _passwordTextEditingController.text;
    User userToSave = User(
      user: user,
      password: password,
      modelData: predictedData,
    );
    await databaseHelper.insert(userToSave);
    _mlService.setPredictedData([]);
  }

  Future _signIn(BuildContext context) async {
    String password = _passwordTextEditingController.text;
    if (predictedUser!.password == password) {
      context.showSnackBar(message: 'Login!', backgroundColor: Colors.green);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Wrong password!'),
          );
        },
      );
    }
  }

  Future<User?> _predictUser() async {
    User? userAndPass = await _mlService.predict();
    return userAndPass;
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
        }
        if (!mounted) return;
        PersistentBottomSheetController bottomSheetController =
            Scaffold.of(context)
                .showBottomSheet((context) => signSheet(context));
        bottomSheetController.closed.whenComplete(() => widget.reload());
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[200],
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CAPTURE',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.camera_alt, color: Colors.white)
          ],
        ),
      ),
    );
  }

  signSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isLogin && predictedUser != null
              ? Text(
                  'Welcome back, ${predictedUser!.user}.',
                  style: const TextStyle(fontSize: 20),
                )
              : widget.isLogin
                  ? const Text(
                      'User not found 😞',
                      style: TextStyle(fontSize: 20),
                    )
                  : Container(),
          Column(
            children: [
              !widget.isLogin
                  ? CustomTextField(
                      controller: _userTextEditingController,
                      label: "Your Name",
                    )
                  : Container(),
              const SizedBox(height: 10),
              widget.isLogin && predictedUser == null
                  ? Container()
                  : CustomTextField(
                      controller: _passwordTextEditingController,
                      label: "Password",
                    ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              widget.isLogin && predictedUser != null
                  ? AppButton(
                      text: 'LOGIN',
                      onPressed: () async {
                        _signIn(context);
                      },
                      icon: const Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                    )
                  : !widget.isLogin
                      ? AppButton(
                          text: 'SIGN UP',
                          onPressed: () async {
                            await _signUp(context).then((value) {
                              context.showSnackBar(
                                  message: 'Register success!',
                                  backgroundColor: Colors.green);
                              Navigator.pushReplacementNamed(
                                  context, IndexPage.route);
                            });
                          },
                          icon: const Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                        )
                      : Container(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
