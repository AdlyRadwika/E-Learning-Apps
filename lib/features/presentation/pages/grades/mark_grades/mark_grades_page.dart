import 'package:final_project/features/presentation/pages/grades/assignment_grades/assignment_grades_page.dart';
import 'package:final_project/features/presentation/pages/grades/final_grades/final_grades_page.dart';
import 'package:final_project/features/presentation/pages/grades/widgets/assignment_grade_list.dart';
import 'package:final_project/features/presentation/pages/grades/widgets/final_grade_list.dart';
import 'package:flutter/material.dart';

class MarkGradePage extends StatelessWidget {
  static const route = '/mark-grade';

  const MarkGradePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark Grades'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Final Grades',
                    style: theme.textTheme.titleLarge,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, FinalGradesPage.route),
                    child: const Text(
                      'See More',
                    ),
                  ),
                ],
              ),
            ),
            const FinalGradeList(shouldLimit: true),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Assignment Grades',
                    style: theme.textTheme.titleLarge,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, AssignmentGradesPage.route),
                    child: const Text(
                      'See More',
                    ),
                  ),
                ],
              ),
            ),
            const AssignmentGradeList(shouldLimit: true),
          ],
        ),
      ),
    );
  }
}
