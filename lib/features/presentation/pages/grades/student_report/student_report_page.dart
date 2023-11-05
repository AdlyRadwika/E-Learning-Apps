import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/presentation/bloc/grade_cloud/get_grade/get_grades_bloc.dart';
import 'package:final_project/features/presentation/pages/grades/student_report/widgets/student_assignments_content.dart';
import 'package:final_project/features/presentation/pages/grades/student_report/widgets/student_final_grade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class StudentReportPage extends StatefulWidget {
  static const route = '/student-report';

  final String classCode;
  final String studentId;
  final String studentName;

  const StudentReportPage(
      {super.key,
      required this.classCode,
      required this.studentId,
      required this.studentName});

  @override
  State<StudentReportPage> createState() => _StudentReportPageState();
}

class _StudentReportPageState extends State<StudentReportPage> {
  void _getData() {
    context.read<GetGradesBloc>().add(GetGradesByStudentEvent(
        classCode: widget.classCode, studentId: widget.studentId));
  }

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(UserConfigUtil.role == 'teacher'
            ? "${widget.studentName}'s Report"
            : 'Class 1 Report'),
        actions: [
          IconButton(
              onPressed: () => print,
              tooltip: 'Download',
              icon: const Icon(Icons.download))
        ],
      ),
      body:
          BlocBuilder<GetGradesBloc, GetGradesState>(builder: (context, state) {
        if (state is GetGradesByStudentLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetGradesByStudentResult && !state.isSuccess) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () => _getData(),
                    child: const Text('Try Again')),
              ],
            ),
          );
        }

        if (state is GetGradesByStudentResult && state.isSuccess) {
          final data = state.grade;
          return SlidingUpPanel(
            color: theme.colorScheme.background,
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 10.0,
            ),
            minHeight: 60,
            maxHeight: 140,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            panelBuilder: () => StudentFinalGrade(
              theme: theme,
              data: data,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: StudentAssignmentContent(
                theme: theme,
                data: data,
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Something went wrong."),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () => _getData(), child: const Text('Try Again')),
            ],
          ),
        );
      }),
    );
  }
}
