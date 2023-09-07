import 'package:flutter/material.dart';

class NavigateRichTextWidget extends StatelessWidget {
  const NavigateRichTextWidget({
    super.key,
    required this.questionText,
    required this.btnText, required this.route,
  });

  final String questionText;
  final String btnText;
  final String route;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: RichText(
          text: TextSpan(style: theme.textTheme.bodyLarge, children: [
        TextSpan(text: '$questionText '),
        TextSpan(
            text: btnText,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            )),
      ])),
    );
  }
}
