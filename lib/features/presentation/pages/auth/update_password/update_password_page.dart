import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
import 'package:final_project/features/presentation/widgets/custom_dialog.dart';
import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordPage extends StatefulWidget {
  static const route = '/update-password';

  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  late TextEditingController oldPassC;
  late TextEditingController newPassC;
  late TextEditingController newPassConfirmC;

  @override
  void initState() {
    super.initState();

    oldPassC = TextEditingController();
    newPassC = TextEditingController();
    newPassConfirmC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    oldPassC.dispose();
    newPassC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Update Password')),
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
                      CustomTextField(
                        controller: oldPassC,
                        label: 'Old Password',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: newPassC,
                        label: 'New Password',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: newPassConfirmC,
                        label: 'New Password Confirmation',
                      ),
                    ],
                  ),
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is UpdatePasswordResult && state.isSuccess) {
                      showResultDialog(context,
                          routeName: HomePage.route,
                          isSuccess: true,
                          labelContent: 'Your password has been updated.');
                    } else if (state is UpdatePasswordResult &&
                        !state.isSuccess) {
                      context.showErrorSnackBar(message: state.message);
                    }
                  },
                  child: BlocBuilder<UserCloudBloc, UserCloudState>(
                      builder: (context, state) {
                    if (state is GetUserByIdResult && state.isSuccess) {
                      final data = state.user;
                      return ElevatedButton(
                          onPressed: () {
                            _updatePassword(email: data?.email ?? "-");
                          },
                          child: const Text('Continue'));
                    }
                    return const ElevatedButton(
                        onPressed: null, child: Text('Continue'));
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updatePassword({required String email}) {
    final oldPass = oldPassC.text.trim();
    final newPass = newPassC.text.trim();
    final newPassConfirm = newPassConfirmC.text.trim();
    if (oldPass.isEmpty && newPass.isEmpty && newPassConfirm.isEmpty ||
        oldPass.isEmpty ||
        newPass.isEmpty ||
        newPassConfirm.isEmpty) {
      context.showErrorSnackBar(message: 'Input(s) should be filled!');
      return;
    }
    if (newPassConfirm != newPass) {
      context.showErrorSnackBar(message: 'Your new password should be same!');
      return;
    }
    context.read<AuthBloc>().add(UpdatePasswordEvent(
          email: email,
          newPass: newPassConfirm,
          oldPass: oldPass,
        ));
  }
}
