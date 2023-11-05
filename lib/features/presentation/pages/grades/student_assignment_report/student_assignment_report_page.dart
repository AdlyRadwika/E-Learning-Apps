import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/services/uuid_service.dart';
import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/domain/entities/grade/grade.dart';
import 'package:final_project/features/domain/entities/grade/grade_content.dart'
    as ent;
import 'package:final_project/features/presentation/bloc/grade_cloud/get_grade/get_grades_bloc.dart';
import 'package:final_project/features/presentation/bloc/grade_cloud/grade_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/grades/student_assignment_report/widgets/grade_content.dart';
import 'package:final_project/features/presentation/pages/grades/student_assignment_report/widgets/student_assignment_report_body.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class StudentAssignmentReportPage extends StatefulWidget {
  static const route = '/student-assignment-report';

  final ent.AssignmentDetail data;
  final String studentId;
  final String classCode;

  const StudentAssignmentReportPage({
    super.key,
    required this.data,
    required this.studentId,
    required this.classCode,
  });

  @override
  State<StudentAssignmentReportPage> createState() =>
      _StudentAssignmentReportPageState();
}

class _StudentAssignmentReportPageState
    extends State<StudentAssignmentReportPage> {
  final _uuidService = locator<UuidService>();

  final _formKey = GlobalKey<FormState>();

  final _gradeC = TextEditingController();

  int _grade = -1;

  void _refreshGrades() {
    context.read<GetGradesBloc>().add(GetGradesByStudentEvent(
        classCode: widget.classCode, studentId: widget.studentId));
  }

  @override
  void initState() {
    super.initState();

    _grade = widget.data.grade;
  }

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
            title: const Text("Assignment Report"),
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
                        grade: _grade,
                        formKey: _formKey,
                        theme: theme,
                        gradeC: _gradeC,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      BlocListener<GradeCloudBloc, GradeCloudState>(
                        listener: (context, state) {
                          if (state is InsertGradeResult && state.isSuccess) {
                            setState(() {
                              _grade = int.tryParse(_gradeC.text) ?? 0;
                            });
                            _refreshGrades();
                            context.showSuccessSnackBar(
                                message: 'This assignment has been graded!');
                          } else if (state is InsertGradeResult &&
                              !state.isSuccess) {
                            context.showErrorSnackBar(context,
                                message: state.message);
                          }
                        },
                        child: _grade == 0
                            ? ElevatedButton(
                                onPressed: () => _submit(),
                                child: const Text('Submit'))
                            : const SizedBox.shrink(),
                      )
                    ],
                  ),
                  body: Body(
                    theme: theme,
                    data: widget.data,
                  ),
                )
              : Body(
                  theme: theme,
                  data: widget.data,
                )),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final data = Grade(
          id: _uuidService.generateUuidV4(),
          grade: int.parse(_gradeC.text),
          classCode: widget.classCode,
          studentId: widget.studentId,
          updatedAt: '-',
          createdAt: DateTime.now().toString(),
          assignmentId: widget.data.assignmentId);
      context.read<GradeCloudBloc>().add(InsertGradeEvent(data: data));
    }
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.theme,
    required this.data,
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
