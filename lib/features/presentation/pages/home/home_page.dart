import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/index/class_index_page.dart';
import 'package:final_project/features/presentation/pages/home/widgets/appbar_content.dart';
import 'package:final_project/features/presentation/pages/home/widgets/home_content.dart';
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

  static const _navbarPage = [
    HomeContent(),
    ClassIndexPage(),
    Scaffold(
      body: Center(
        child: Text('Coming soon'),
      ),
    )
  ];

  int _currentIndex = 0;

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _getData() {
    context
        .read<UserCloudBloc>()
        .add(GetUserByIdEvent(uid: auth.currentUser?.uid ?? "-"));

    UserConfigUtil.uid = auth.currentUser?.uid ?? "-";
  }

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarContent(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: _navbarPage.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onTapped, currentIndex: _currentIndex, items: _navbarItems),
    );
  }
}
