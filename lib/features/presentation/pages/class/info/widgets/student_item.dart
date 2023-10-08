import 'package:flutter/material.dart';

class StudentItem extends StatelessWidget {
  const StudentItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(
          "Student",
          style: theme.textTheme.labelLarge,
        ),
        subtitle: Text('Joined at ${DateTime.now().toString()}'),
      ),
    );
  }
}
