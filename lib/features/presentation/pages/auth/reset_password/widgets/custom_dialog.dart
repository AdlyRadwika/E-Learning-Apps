import 'package:final_project/features/presentation/pages/auth/login/login_page.dart';
import 'package:flutter/material.dart';

Future<void> showResultDialog(
  BuildContext context, {
  required bool isSuccess,
  required String labelContent,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return _ResultDialog(
        isSuccess: isSuccess,
        labelContent: labelContent,
      );
    },
  );
}

class _ResultDialog extends StatelessWidget {
  final bool isSuccess;
  final String labelContent;

  const _ResultDialog({
    required this.isSuccess,
    required this.labelContent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      // title: Image.asset(
      //   isSuccess ? AssetsConst.imageSuccessIcon : AssetsConst.imageErrorIcon,
      //   height: 60.h,
      //   width: 60.h,
      //   fit: BoxFit.fitHeight,
      // ),
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
                Text(
                  isSuccess ? 'Success!' : 'Failed!',
                  style: theme.textTheme.labelLarge,
                  textScaleFactor: 1.1,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    isSuccess
                        ? Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginPage.route,
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
