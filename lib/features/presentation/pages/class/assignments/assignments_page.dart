import 'package:final_project/features/presentation/bloc/assignment_cloud/get_assignment/get_assignment_bloc.dart';
import 'package:final_project/features/presentation/pages/class/widgets/add_assignment_widget.dart';
import 'package:final_project/features/presentation/pages/class/widgets/assignment_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignmentsPage extends StatefulWidget {
  static const route = '/class-assignments';

  final String classCode;

  const AssignmentsPage({super.key, required this.classCode});

  @override
  State<AssignmentsPage> createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  @override
  void initState() {
    super.initState();

    context
        .read<GetAssignmentsBloc>()
        .add(GetAssignmentsByClassEvent(classCode: widget.classCode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AddAssignmentWidget(
                classCode: widget.classCode,
                data: null,
                isEdit: false,
              ),
            ),
            AssignmentListWidget(
              shouldLimit: false,
              classCode: widget.classCode,
            ),
          ],
        ),
      ),
    );
  }
}
