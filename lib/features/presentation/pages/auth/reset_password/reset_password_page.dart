import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/widgets/custom_dialog.dart';
import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  static const route = '/reset-password';

  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late TextEditingController emailC;

  @override
  void initState() {
    super.initState();

    emailC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    emailC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Reset Password')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Input your email",
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: emailC,
                        label: 'Email',
                      ),
                    ],
                  ),
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is ResetPasswordResult && state.isSuccess) {
                      showResultDialog(context,
                          isSuccess: true,
                          labelContent:
                              'Your request for reset password has been sent to email.');
                    } else if (state is ResetPasswordResult &&
                        !state.isSuccess) {
                      context.showErrorSnackBar(message: state.message);
                    }
                  },
                  child: ElevatedButton(
                      onPressed: () {
                        _resetPassword();
                      },
                      child: const Text('Continue')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resetPassword() {
    final email = emailC.text.trim();
    if (email.isEmpty) {
      context.showErrorSnackBar(message: 'Email should be filled!');
      return;
    }
    context.read<AuthBloc>().add(ResetPasswordEvent(
          email: email,
        ));
  }
}
