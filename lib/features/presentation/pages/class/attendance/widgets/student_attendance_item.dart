import 'package:final_project/common/util/date_util.dart';
import 'package:flutter/material.dart';

class StudentAttendanceItem extends StatelessWidget {
  const StudentAttendanceItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Student 1'),
        subtitle: Text(DateUtil.formatDate(DateTime.now().toString())),
      ),
    );
  }
}
