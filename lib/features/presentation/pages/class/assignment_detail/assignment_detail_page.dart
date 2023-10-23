import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_submission_status/get_submission_bloc.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_submitted_assignments/get_submitted_assignment_bloc.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_unsubmitted_assignments/get_unsubmitted_assignment_bloc.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/assignment_detail/widgets/assignment_info.dart';
import 'package:final_project/features/presentation/pages/class/assignment_detail/widgets/submission_content.dart';
import 'package:final_project/features/presentation/pages/class/assignment_detail/widgets/teacher_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class AssignmentDetailPage extends StatefulWidget {
  static const route = '/assignment-detail';

  final Assignment? data;

  const AssignmentDetailPage({super.key, required this.data});

  @override
  State<AssignmentDetailPage> createState() => _AssignmentDetailPageState();
}

class _AssignmentDetailPageState extends State<AssignmentDetailPage> {
  void _getData() {
    final assignmentData = widget.data;
    context.read<GetSubmissionsBloc>().add(GetSubmissionsStatusEvent(
        assignmentId: widget.data?.id ?? "-", studentId: UserConfigUtil.uid));

    if (UserConfigUtil.role == 'teacher') {
      context.read<GetSubmittedAssignmentsBloc>().add(
          FetchSubmittedAssignmentEvent(
              assignmentId: assignmentData?.id ?? '-'));
      context.read<GetUnsubmittedAssignmentsBloc>().add(
          FetchUnsubmittedAssignmentEvent(
              assignmentId: assignmentData?.id ?? '-'));
    }
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
        title: const Text('Assignment Detail'),
      ),
      body:
          BlocBuilder<UserCloudBloc, UserCloudState>(builder: (context, state) {
        if (state is GetUserByIdResult && state.isSuccess) {
          final isTeacher = state.user?.role == "teacher";
          if (isTeacher) {
            return TeacherContent(data: widget.data);
          }
        }
        return SlidingUpPanel(
          color: theme.colorScheme.background,
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 10.0,
          ),
          maxHeight: 400,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          panelBuilder: () => SubmissionContent(
            data: widget.data,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: AssignmentInfo(isTeacher: false, data: widget.data),
          ),
        );
      }),
    );
  }
}
