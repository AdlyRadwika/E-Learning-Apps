import 'package:final_project/features/domain/entities/class/class.dart';
import 'package:final_project/features/presentation/pages/class/detail/class_detail.dart';
import 'package:flutter/material.dart';

class ClassItem extends StatelessWidget {
  final Class? data;

  const ClassItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.lightBlue[200],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () => Navigator.pushNamed(context, ClassDetailPage.route, arguments: {
            'data': data,
          }),
          child: Center(
            child: Text(data?.title ?? "Unknown Class"),
          ),
        ),
      ),
    );
  }
}
