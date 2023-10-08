import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/features/presentation/pages/auth/login/login_page.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const route = '/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _storageService = locator<SecureStorageService>();

  Future<void> _getData(BuildContext context) async {
    final uid = await _storageService.getUid();
    if (mounted) {
      if (uid.isEmpty || uid == "-") {
        Navigator.pushNamedAndRemoveUntil(
            context, LoginPage.route, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.route, (route) => false);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _getData(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'E-Learning Mobile Apps',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Adly Radwika Maulid Fajri\nC30109200033',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
