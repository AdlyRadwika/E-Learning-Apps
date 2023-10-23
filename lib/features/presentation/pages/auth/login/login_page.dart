import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/features/domain/entities/user/user.dart' as app;
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/pages/auth/login/widgets/navigate_rich_text_widget.dart';
import 'package:final_project/features/presentation/pages/auth/register/register_page.dart';
import 'package:final_project/features/presentation/pages/auth/reset_password/reset_password_page.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:final_project/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static const route = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = FirebaseAuth.instance;

  final _storageService = locator.get<SecureStorageService>();

  final _formKey = GlobalKey<FormState>();
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextFormField(
                          icon: Icons.alternate_email,
                          controller: emailC,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          icon: Icons.lock,
                          controller: passC,
                          isPassword: true,
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
                ),
                Column(
                  children: [
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is LoginResult && state.isSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomePage.route,
                            (route) => false,
                          );
                        } else if (state is LoginResult && !state.isSuccess) {
                          context.showErrorSnackBar(context,
                              message: state.message);
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

    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginEvent(email: email, password: pass));
      final user = app.User(
          name: '-',
          email: email,
          imageUrl: '-',
          imageData: [],
          role: '-',
          updatedAt: '-',
          createdAt: '-',
          uid: auth.currentUser?.uid ?? "-");
      _storageService.saveUserData(user: user);
    }
  }
}
