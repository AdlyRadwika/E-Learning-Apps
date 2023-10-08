
import 'package:flutter/material.dart';

class AttendanceItem extends StatelessWidget {
  const AttendanceItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Attendance 1'),
        subtitle: Text(DateTime.now().toString()),
      ),
    );
  }
}