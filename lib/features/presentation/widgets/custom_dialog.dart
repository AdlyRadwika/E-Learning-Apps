import 'package:final_project/features/presentation/pages/auth/login/login_page.dart';
import 'package:flutter/material.dart';

Future<void> showResultDialog(
  BuildContext context, {
  required bool isSuccess,
  String routeName = LoginPage.route,
  required String labelContent,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return _ResultDialog(
        isSuccess: isSuccess,
        labelContent: labelContent,
        routeName: routeName,
      );
    },
  );
}

class _ResultDialog extends StatelessWidget {
  final bool isSuccess;
  final String labelContent;
  final String routeName;

  const _ResultDialog({
    required this.isSuccess,
    required this.labelContent, required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(
        isSuccess ? 'Success!' : 'Failed!',
        style: theme.textTheme.labelLarge,
        textScaleFactor: 1.1,
      ),
      content: Wrap(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    labelContent,
                    style: theme.textTheme.labelLarge,
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.1,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    isSuccess
                        ? Navigator.pushNamedAndRemoveUntil(
                            context,
                            routeName,
                            (route) => false,
                          )
                        : Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    textStyle: theme.textTheme.titleSmall,
                  ),
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
