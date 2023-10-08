
import 'package:flutter/material.dart';

class TeacherSection extends StatelessWidget {
  const TeacherSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Teacher',
          style: theme.textTheme.titleLarge,
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              'Teacher 1',
              style: theme.textTheme.labelLarge,
            ),
            subtitle: Text('Joined at ${DateTime.now().toString()}'),
          ),
        )
      ],
    );
  }
}