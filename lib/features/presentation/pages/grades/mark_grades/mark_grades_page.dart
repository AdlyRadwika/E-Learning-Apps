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
                ],
              ),
            ),
            const FinalGradeList(shouldLimit: false),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
