import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailC,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: passC,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoginResult && state.isSuccess) {
                    Navigator.pushReplacementNamed(context, HomePage.route);
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
            ],
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
