import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/auth/update_password/update_password_page.dart';
import 'package:final_project/features/presentation/pages/face_recognition/face_recognitionv2_page.dart';
import 'package:final_project/features/presentation/widgets/custom_dialog.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  static const route = '/profile';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _storageService = locator<SecureStorageService>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: BlocBuilder<UserCloudBloc, UserCloudState>(
                  builder: (context, state) {
                if (state is GetUserByIdResult && state.isSuccess) {
                  final data = state.user;
                  return CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                        data?.imageUrl ?? AssetConts.imageUserDefault),
                    backgroundColor: Colors.grey,
                  );
                }
                return const CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.grey,
                );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: BlocBuilder<UserCloudBloc, UserCloudState>(
                  builder: (context, state) {
                if (state is GetUserByIdResult && state.isSuccess) {
                  final data = state.user;
                  return Column(
                    children: [
                      Text(
                        data?.name ?? "Unknown",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data?.email ?? "Unknown@mail.com",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data?.role ?? "Unknown Role",
                      ),
                    ],
                  );
                }
                return Text(
                  "...",
                  style: theme.textTheme.titleLarge,
                );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Card(
                  child: ListTile(
                    onTap: () => Navigator.pushNamed(
                        context, FaceRecognitionV2Page.route,
                        arguments: {
                          "isAttendace": false,
                          "isUpdate": true,
                        }),
                    title: const Text('Edit Photo Profile'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, UpdatePasswordPage.route),
                    title: const Text('Edit Password'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
            onPressed: () {
              showResultDialog(
                context,
                isSuccess: true,
                showCancelBtn: true,
                labelContent: 'Are you sure you want to logout?',
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                  _storageService.deleteUserData();
                },
              );
            },
            child: const Text('Logout')),
      ),
    );
  }
}
