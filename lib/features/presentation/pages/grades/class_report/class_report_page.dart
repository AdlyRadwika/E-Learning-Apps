import 'package:final_project/features/presentation/bloc/class_cloud/get_class_students/get_class_students_bloc.dart';
import 'package:final_project/features/presentation/pages/grades/class_report/widgets/student_report_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassReportPage extends StatefulWidget {
  static const route = '/class-report';

  final String classCode;
  final String className;


  const ClassReportPage({super.key, required this.classCode, required this.className});

  @override
  State<ClassReportPage> createState() => _ClassReportPageState();
}

class _ClassReportPageState extends State<ClassReportPage> {
  @override
  void initState() {
    super.initState();

    context
        .read<GetClassStudentsBloc>()
        .add(FetchStudentsEvent(classCode: widget.classCode));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.className}'s Report"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'Students',
                style: theme.textTheme.titleLarge,
              ),
            ),
            StudentReportList(classCode: widget.classCode)
          ],
        ),
      ),
    );
  }
}
