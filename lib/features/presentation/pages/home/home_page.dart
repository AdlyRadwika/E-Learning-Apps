import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/home/widgets/appbar_content.dart';
import 'package:final_project/features/presentation/pages/home/widgets/calendar_widget.dart';
import 'package:final_project/features/presentation/pages/home/widgets/grade_widget.dart';
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

  static const _navbarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      tooltip: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.class_),
      label: 'Class',
      tooltip: 'Class',
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.inbox), label: 'Inbox', tooltip: 'Inbox'),
  ];

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
        title: const AppBarContent(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ElevatedButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, ProfilePage.route),
                icon: const Icon(Icons.edit),
                label: const Text('Configure Your Profile')),
            const SizedBox(
              height: 20,
            ),
            const GradeWidget(),
            const SizedBox(
              height: 20,
            ),
            const CalendarWidget()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: _navbarItems),
    );
  }
}
