import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/face_recognition/face_recognitionv2_page.dart';
import 'package:final_project/features/presentation/pages/profile/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const route = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    context
        .read<UserCloudBloc>()
        .add(GetUserByIdEvent(uid: auth.currentUser?.uid ?? "-"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<UserCloudBloc, UserCloudState>(
          builder: (context, state) {
            if (state is GetUserByIdResult && state.isSuccess) {
              final data = state.user;
              return Text('Home - ${data?.role ?? "-"}');
            }
            if (state is GetUserByIdResult && !state.isSuccess) {
              return const Text('Home - No Role');
            }
            return const Text('Home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, ProfilePage.route),
                icon: const Icon(Icons.edit),
                label: const Text('Configure Your Profile')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, FaceRecognitionV2Page.route,
                      arguments: {
                        "isAttendance": true,
                        "isUpdate": false,
                      });
                },
                child: const Text('Face Recognition')),
          ],
        ),
      ),
    );
  }
}
