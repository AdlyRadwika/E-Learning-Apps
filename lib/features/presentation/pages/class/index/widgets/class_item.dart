import 'package:final_project/features/presentation/pages/class/detail/class_detail.dart';
import 'package:flutter/material.dart';

class ClassItem extends StatelessWidget {
  const ClassItem({
    super.key,
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
          onTap: () => Navigator.pushNamed(context, ClassDetailPage.route),
          child: const Center(
            child: Text('Class'),
          ),
        ),
      ),
    );
  }
}
