import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  /// Displays a basic snackbar
  void showSnackBar({
    required String message,
    Color textColor = Colors.white,
    Color backgroundColor = Colors.black,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar(BuildContext context, {required String message}) {
    final themeColor = Theme.of(context).colorScheme;
    showSnackBar(
        message: message,
        backgroundColor: themeColor.errorContainer,
        textColor: themeColor.onErrorContainer);
  }

  void showSuccessSnackBar({required String message}) {
    showSnackBar(
        message: message,
        backgroundColor: const Color(0xff74ff6c),
        textColor: const Color(0xff002202));
  }
}
