import 'package:final_project/common/util/date_util.dart';
import 'package:flutter/material.dart';

class AttendanceItem extends StatelessWidget {
  const AttendanceItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.check),
        title: const Text('Attendance 1'),
        subtitle: Text(DateUtil.formatDate(DateTime.now().toString())),
      ),
    );
  }
}
