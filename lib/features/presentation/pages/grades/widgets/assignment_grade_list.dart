import 'package:flutter/material.dart';

class AssignmentGradeList extends StatelessWidget {
  final bool shouldLimit;

  const AssignmentGradeList({
    super.key,
    required this.shouldLimit,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: shouldLimit ? 3 : 7,
      itemBuilder: (context, index) {
        return const _AssignmentGradeItem();
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
    );
  }
}

class _AssignmentGradeItem extends StatelessWidget {
  const _AssignmentGradeItem();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => print,
        leading: const Icon(Icons.assignment_outlined),
        title: const Text('Assignment 1 Report'),
        subtitle: const Text('Class 1'),
        trailing: IconButton(
            onPressed: () => print, icon: const Icon(Icons.arrow_forward_ios)),
      ),
    );
  }
}
