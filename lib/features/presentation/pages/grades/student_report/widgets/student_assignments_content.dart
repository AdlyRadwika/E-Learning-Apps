import 'package:final_project/features/domain/entities/grade/grade_content.dart';
import 'package:final_project/features/presentation/pages/grades/widgets/student_assignment_item.dart';
import 'package:flutter/material.dart';

class StudentAssignmentContent extends StatelessWidget {
  final GradeContent? data;

  const StudentAssignmentContent({
    super.key,
    required this.theme,
    required this.data,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final list = data?.details;
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
        list?.isEmpty == true
            ? const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child:
                        Text("This student hasn't submit any assignment yet."),
                  ),
                ),
              )
            : SliverList.separated(
                itemCount: list?.length,
                itemBuilder: (context, index) {
                  final itemData = list?[index];
                  return StudentAssignmentItem(
                    data: itemData,
                    theme: theme,
                    classCode: data?.classCode ?? '-',
                    user: data?.user,
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
