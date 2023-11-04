import 'package:final_project/features/domain/entities/grade/grade_content.dart';
import 'package:final_project/features/presentation/pages/grades/widgets/student_assignment_item.dart';
import 'package:flutter/material.dart';

class StudentAssignmentContent extends StatelessWidget {
  final List<AssignmentDetail>? data;

  const StudentAssignmentContent({
    super.key,
    required this.theme,
    required this.data,
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
          itemCount: data?.length,
          itemBuilder: (context, index) {
            final itemData = data?[index];
            return StudentAssignmentItem(
              data: itemData,
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
