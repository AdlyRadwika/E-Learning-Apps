import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
          child: Text(
        'Calendar',
        style: theme.textTheme.bodyLarge
            ?.copyWith(color: theme.colorScheme.onSecondaryContainer),
      )),
    );
  }
}
