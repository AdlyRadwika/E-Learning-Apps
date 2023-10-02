import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/pages/auth/login/widgets/navigate_rich_text_widget.dart';
import 'package:final_project/features/presentation/pages/auth/register/register_page.dart';
import 'package:final_project/features/presentation/pages/auth/reset_password/reset_password_page.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static const route = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailC;
  late TextEditingController passC;

  @override
  void initState() {
    super.initState();

    emailC = TextEditingController();
    passC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    emailC.dispose();
    passC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
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
                      const NavigateRichTextWidget(
                        questionText: 'Forget password?',
                        btnText: 'Reset here',
                        route: ResetPasswordPage.route,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is LoginResult && state.isSuccess) {
                          Navigator.pushReplacementNamed(
                              context, HomePage.route);
                        } else if (state is LoginResult && !state.isSuccess) {
                          context.showErrorSnackBar(message: state.message);
                        }
                      },
                      child: ElevatedButton(
                          onPressed: () {
                            _login();
                          },
                          child: const Text('Login')),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const NavigateRichTextWidget(
                      questionText: "Doesn't have an account?",
                      btnText: 'Register here',
                      route: RegisterPage.route,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    final email = emailC.text.trim();
    final pass = passC.text.trim();
    if (email.isEmpty && pass.isEmpty || email.isEmpty || pass.isEmpty) {
      context.showErrorSnackBar(message: 'Email or password should be filled!');
      return;
    }
    context.read<AuthBloc>().add(LoginEvent(email: email, password: pass));
  }
}
