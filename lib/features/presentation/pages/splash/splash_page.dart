import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/common/util/switch_theme_util.dart';
import 'package:final_project/features/presentation/pages/auth/login/login_page.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
import 'package:final_project/features/presentation/widgets/logo_widget.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      context.read<SwitchThemeProvider>().initTheme();
    }
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

    Future.delayed(
      const Duration(seconds: 3),
      () => _getData(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(theme: theme),
            const SizedBox(
              height: 20,
            ),
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
