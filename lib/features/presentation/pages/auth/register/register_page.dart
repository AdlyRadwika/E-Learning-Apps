import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  static const route = '/register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController emailC;
  late TextEditingController passC;
  late TextEditingController confirmPassC;

  @override
  void initState() {
    super.initState();

    emailC = TextEditingController();
    passC = TextEditingController();
    confirmPassC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    emailC.dispose();
    passC.dispose();
    confirmPassC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: emailC,
                      label: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: passC,
                      label: 'Password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: confirmPassC,
                      label: 'Password Confirmation',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is RegisterResult && state.isSuccess) {
              Navigator.pushReplacementNamed(context, HomePage.route);
            } else if (state is RegisterResult && !state.isSuccess) {
              context.showErrorSnackBar(message: state.message);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  _register();
                },
                child: const Text('Register')),
          ),
        ),
      ),
    );
  }

  void _register() {
    final email = emailC.text.trim();
    final pass = passC.text.trim();
    final confirmPass = confirmPassC.text.trim();

    if (email.isEmpty && pass.isEmpty && confirmPass.isEmpty ||
        email.isEmpty ||
        pass.isEmpty ||
        confirmPass.isEmpty) {
      context.showErrorSnackBar(message: 'The input(s) should be filled!');
      return;
    }
    if (confirmPass != pass) {
      context.showErrorSnackBar(
          message: 'Your password confirmation is not the same!');
      return;
    }

    context
        .read<AuthBloc>()
        .add(RegisterEvent(email: email, password: confirmPass));
  }
}
