import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_submitted_assignments/get_submitted_assignment_bloc.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_unsubmitted_assignments/get_unsubmitted_assignment_bloc.dart';
import 'package:final_project/features/presentation/pages/class/assignment_detail/widgets/assignment_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherContent extends StatefulWidget {
  const TeacherContent({
    super.key,
    required this.data,
  });

  final Assignment? data;

  @override
  State<TeacherContent> createState() => _TeacherContentState();
}

class _TeacherContentState extends State<TeacherContent> {
  Future<void> _launchUrl(String? url) async {
    final uri = Uri.tryParse(url ?? '-');
    if (await canLaunchUrl(uri!)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      context.showErrorSnackBar(
          message: "Your submission file couldn't be opened.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: AssignmentInfo(
                data: widget.data,
                isTeacher: true,
              )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<GetSubmittedAssignmentsBloc,
                GetSubmittedAssignmentsState>(
              builder: (context, state) {
                if (state is FetchSubmittedAssignmentLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FetchSubmittedAssignmentResult &&
                    !state.isSuccess) {
                  return Column(
                    children: [
                      Text(state.message),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.read<GetSubmittedAssignmentsBloc>().add(
                                FetchSubmittedAssignmentEvent(
                                    assignmentId: widget.data?.id ?? '-'));
                          },
                          child: const Text('Try Again'))
                    ],
                  );
                }
                if (state is FetchSubmittedAssignmentResult &&
                    state.isSuccess) {
                  final data = state.data;
                  if (data?.isEmpty == true || data == null) {
                    return const ExpansionTile(
                      title: Text('Submitted Assignments'),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                            child: Text(
                                'There is currently no submitted assignments yet'),
                          ),
                        )
                      ],
                    );
                  }
                  return ExpansionTile(
                      title: const Text('Submitted Assignments'),
                      children: data
                          .map((e) => Card(
                                child: ListTile(
                                  onTap: () => _launchUrl(e.fileUrl),
                                  leading: const Icon(Icons.attachment),
                                  title: Text("${e.studentName}'s Assignment"),
                                  subtitle: Text(
                                      "Submitted at ${DateUtil.formatDate(e.submittedDate)}"),
                                ),
                              ))
                          .toList());
                }
                return const ExpansionTile(
                  title: Text('Submitted Assignments'),
                  children: [
                    Center(
                      child: Text(
                          'There is currently no submitted assignments yet'),
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<GetUnsubmittedAssignmentsBloc,
                GetUnsubmittedAssignmentsState>(
              builder: (context, state) {
                if (state is FetchUnsubmittedAssignmentLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FetchUnsubmittedAssignmentResult &&
                    !state.isSuccess) {
                  return Column(
                    children: [
                      Text(state.message),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.read<GetUnsubmittedAssignmentsBloc>().add(
                                FetchUnsubmittedAssignmentEvent(
                                    assignmentId: widget.data?.id ?? '-'));
                          },
                          child: const Text('Try Again'))
                    ],
                  );
                }
                if (state is FetchUnsubmittedAssignmentResult &&
                    state.isSuccess) {
                  final data = state.data;
                  if (data?.isEmpty == true || data == null) {
                    return const SizedBox.shrink();
                  }
                  return ExpansionTile(
                      title: const Text('Unsubmitted Assignments'),
                      children: data
                          .map((e) => Card(
                                child: ListTile(
                                  leading: const Icon(Icons.warning),
                                  title: Text("${e.studentName}'s Assignment"),
                                  subtitle: const Text(
                                      "There is currently no attachment."),
                                ),
                              ))
                          .toList());
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
