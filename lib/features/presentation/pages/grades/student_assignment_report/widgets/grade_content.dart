import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class GradeContent extends StatelessWidget {
  const GradeContent({
    super.key,
    required this.formKey,
    required this.theme,
    required this.gradeC,
    required this.grade,
  });

  final GlobalKey<FormState> formKey;
  final ThemeData theme;
  final TextEditingController gradeC;
  final int grade;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          Text(
            'Grade',
            style: theme.textTheme.titleLarge,
          ),
          grade == 0
              ? _UngradedContent(gradeC: gradeC)
              : Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        "$grade",
                        style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onSecondaryContainer),
                      )),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _UngradedContent extends StatelessWidget {
  const _UngradedContent({
    required this.gradeC,
  });

  final TextEditingController gradeC;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("It seems that you haven’t set the grade yet."),
        const SizedBox(
          height: 20,
        ),
        CustomTextFormField(
          controller: gradeC,
          label: 'Input Grade',
          maxLength: 3,
          isGrade: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: false),
          icon: Icons.grade_rounded,
        ),
      ],
    );
  }
}
