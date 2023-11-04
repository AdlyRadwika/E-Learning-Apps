import 'package:final_project/features/domain/entities/grade/grade_content.dart';
import 'package:flutter/material.dart';

class StudentFinalGrade extends StatelessWidget {
  final GradeContent? data;

  const StudentFinalGrade({
    super.key,
    required this.theme, required this.data,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Final Grade",
            style: theme.textTheme.headlineMedium,
          ),
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              '${data?.finalGrade ?? 0}',
              style: theme.textTheme.titleLarge
                  ?.copyWith(color: theme.colorScheme.onPrimaryContainer),
            ),
          ),
        )
      ],
    );
  }
}
