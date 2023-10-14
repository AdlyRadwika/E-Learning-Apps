import 'package:final_project/features/presentation/pages/class/assignment_detail/assignment_detail_page.dart';
import 'package:flutter/material.dart';

class AssignmentItem extends StatelessWidget {
  const AssignmentItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, AssignmentDetailPage.route),
        leading: const Icon(Icons.assignment),
        title: const Text('Assignment 1'),
        subtitle: Text('Due ${DateTime.now().toString()}'),
      ),
    );
  }
}
