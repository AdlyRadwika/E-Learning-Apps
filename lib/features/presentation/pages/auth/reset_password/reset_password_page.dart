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
  final _formKey = GlobalKey<FormState>();

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
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "",
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  icon: Icons.alternate_email,
                  controller: emailC,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
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
                      context.showErrorSnackBar(context,
                          message: state.message);
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

    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(ResetPasswordEvent(
            email: email,
          ));
    }
  }
}
