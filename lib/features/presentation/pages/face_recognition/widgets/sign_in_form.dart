import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/features/presentation/pages/face_recognition/model/user_model.dart';
import 'package:final_project/features/presentation/pages/face_recognition/widgets/app_button.dart';
import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignInSheet extends StatelessWidget {
  SignInSheet({Key? key, required this.user}) : super(key: key);
  final User? user;

  final _passwordController = TextEditingController();

  Future _signIn(BuildContext context, User? user) async {
    if (user?.password == _passwordController.text && user != null) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Welcome back, ${user?.user ?? "Undetected"}.',
            style: const TextStyle(fontSize: 20),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              CustomTextField(
                controller: _passwordController,
                label: "Password",
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              AppButton(
                text: 'LOGIN',
                onPressed: () async {
                  _signIn(context, user);
                },
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
