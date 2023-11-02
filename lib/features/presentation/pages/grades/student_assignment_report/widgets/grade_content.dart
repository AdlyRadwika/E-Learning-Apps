
import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class GradeContent extends StatelessWidget {
  const GradeContent({
    super.key,
    required this.formKey,
    required this.theme,
    required this.gradeC,
  });

  final GlobalKey<FormState> formKey;
  final ThemeData theme;
  final TextEditingController gradeC;

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
      ),
    );
  }
}
