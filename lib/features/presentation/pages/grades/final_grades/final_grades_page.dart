import 'package:final_project/features/presentation/pages/grades/widgets/final_grade_list.dart';
import 'package:flutter/material.dart';

class FinalGradesPage extends StatelessWidget {
  static const route = '/final-grades';

  const FinalGradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Final Grades')),
      body: const CustomScrollView(
        slivers: [
          FinalGradeList(shouldLimit: false)
        ],
      ),
    );
  }
}
