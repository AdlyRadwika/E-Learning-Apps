import 'package:final_project/features/presentation/pages/grades/widgets/final_grade_list.dart';
import 'package:flutter/material.dart';

class MarkGradePage extends StatelessWidget {
  static const route = '/mark-grade';

  const MarkGradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark Grades'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomScrollView(
          slivers: [
            FinalGradeList(),
          ],
        ),
      ),
    );
  }
}
