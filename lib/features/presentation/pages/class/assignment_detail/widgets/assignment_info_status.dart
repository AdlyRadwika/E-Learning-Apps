import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_submission_status/get_submission_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignmentInfoStatus extends StatelessWidget {
  const AssignmentInfoStatus({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSubmissionsBloc, GetSubmissionsState>(
        builder: (context, state) {
      if (state is GetSubmissionsStatusResult && state.isSuccess) {
        return StreamBuilder(
          stream: state.statusStream,
          builder: (context, snapshot) {
            final docs = snapshot.data?.docs;
            var data = docs?.map((item) => item.data().toEntity()).toList();
            if (docs?.isEmpty == true || data == null) {
              return AssignmentInfoStatusItem(
                theme: theme,
                isSubmitted: false,
              );
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return AssignmentInfoStatusItem(
              theme: theme,
              submittedDate: DateUtil.formatDate(data.first.createdAt),
              isSubmitted: true,
            );
          },
        );
      }
      return AssignmentInfoStatusItem(
        theme: theme,
        isSubmitted: false,
      );
    });
  }
}

class AssignmentInfoStatusItem extends StatelessWidget {
  final bool isSubmitted;
  final String submittedDate;

  const AssignmentInfoStatusItem({
    super.key,
    required this.theme,
    required this.isSubmitted,
    this.submittedDate = '-',
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isSubmitted ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        isSubmitted ? 'Submitted at $submittedDate' : 'Unsubmitted',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
