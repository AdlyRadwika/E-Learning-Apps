import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/features/domain/entities/attendance/attendance_content.dart';
import 'package:flutter/material.dart';

class AttendanceItem extends StatelessWidget {
  final AttendanceContent? data;

  const AttendanceItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(
              data?.studentImageUrl ?? AssetConts.imageUserDefault),
        ),
        title: Text(data?.label ?? "Unknown Attendance"),
        subtitle: Text(DateUtil.formatDate(
            data?.attendanceDate ?? DateTime.now().toString())),
        trailing: Icon(data == null ? Icons.error : Icons.check),
      ),
    );
  }
}
