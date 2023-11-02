import 'package:final_project/features/presentation/pages/grades/widgets/student_assignment_item.dart';
import 'package:flutter/material.dart';

class StudentAssignmentContent extends StatelessWidget {
  const StudentAssignmentContent({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Text(
            'Assignments',
            style: theme.textTheme.titleLarge,
          ),
        ),
        const SliverToBoxAdapter(
          child: Divider(),
        ),
        SliverList.separated(
          itemCount: 2,
          itemBuilder: (context, index) {
            return StudentAssignmentItem(
              theme: theme,
              showStudentName: false,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        )
      ],
    );
  }
}
