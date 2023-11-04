import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/domain/entities/grade/grade_content.dart' as ent;
import 'package:final_project/features/presentation/pages/grades/student_assignment_report/widgets/grade_content.dart';
import 'package:final_project/features/presentation/pages/grades/student_assignment_report/widgets/student_assignment_report_body.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class StudentAssignmentReportPage extends StatefulWidget {
  static const route = '/student-assignment-report';

  final ent.AssignmentDetail data;

  const StudentAssignmentReportPage({super.key, required this.data});

  @override
  State<StudentAssignmentReportPage> createState() =>
      _StudentAssignmentReportPageState();
}

class _StudentAssignmentReportPageState
    extends State<StudentAssignmentReportPage> {
  final _formKey = GlobalKey<FormState>();

  final _gradeC = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _gradeC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Student 1's Assignment"),
          ),
          body: UserConfigUtil.role == 'teacher'
              ? SlidingUpPanel(
                  color: theme.colorScheme.background,
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 10.0,
                  ),
                  maxHeight: 300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  panelBuilder: () => Column(
                    children: [
                      GradeContent(
                        formKey: _formKey,
                        theme: theme,
                        gradeC: _gradeC,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                          onPressed: () => _submit(),
                          child: const Text('Submit'))
                    ],
                  ),
                  body: Body(theme: theme, data: widget.data,),
                )
              : Body(theme: theme, data: widget.data,)),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.showSuccessSnackBar(message: 'Hello!');
    }
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.theme, required this.data,
  });

  final ThemeData theme;
  final ent.AssignmentDetail data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: StudentAssignmentReportBody(theme: theme, data: data),
    );
  }
}
