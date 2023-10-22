import 'dart:io';

import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/domain/entities/assignment/submission.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_submission_status/get_submission_bloc.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/upload_submission/upload_submission_bloc.dart';
import 'package:final_project/features/presentation/pages/class/assignment_detail/widgets/attachment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmissionContent extends StatefulWidget {
  final Assignment? data;

  const SubmissionContent({
    super.key,
    required this.data,
  });

  @override
  State<SubmissionContent> createState() => _SubmissionContentState();
}

class _SubmissionContentState extends State<SubmissionContent> {
  File? _submissionFile;

  void _setSubmissionFile(File file) {
    setState(() {
      _submissionFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<GetSubmissionsBloc, GetSubmissionsState>(
        builder: (context, state) {
      if (state is GetSubmissionsStatusResult && state.isSuccess) {
        return StreamBuilder(
          stream: state.statusStream,
          builder: (context, snapshot) {
            final docs = snapshot.data?.docs;
            final data = docs?.map((item) => item.data().toEntity()).toList();

            if (docs?.isEmpty == true || data == null) {
              return UnsubmittedContent(
                  data: null,
                  submissionFile: _submissionFile,
                  theme: theme,
                  onUpload: _setSubmissionFile,
                  onSubmit: () => _submit());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return SubmittedContent(data: data.first, theme: theme);
          },
        );
      }
      return UnsubmittedContent(
          data: null,
          submissionFile: _submissionFile,
          theme: theme,
          onUpload: _setSubmissionFile,
          onSubmit: () => _submit());
    });
  }

  Future<void> _submit() async {
    final file = _submissionFile;
    final studentId = UserConfigUtil.uid;
    final assignmentId = widget.data?.id ?? "-";

    if (file == null) {
      return;
    }

    if (assignmentId == '-') {
      return;
    }

    context.read<UploadSubmissionBloc>().add(GetSubmissionFileEvent(
        file: file, studentId: studentId, assignmentId: assignmentId));
  }
}

class SubmittedContent extends StatelessWidget {
  final ThemeData theme;
  final Submission? data;

  const SubmittedContent({
    super.key,
    required this.theme,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        Text(
          'Submission',
          style: theme.textTheme.titleLarge,
        ),
        const Text("You have submitted the assignment."),
        const SizedBox(
          height: 40,
        ),
        AttachmentWidget(data: data, theme: theme, onUpload: null),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class UnsubmittedContent extends StatelessWidget {
  final ThemeData theme;
  final Submission? data;
  final Function(File file) onUpload;
  final File? submissionFile;
  final Function() onSubmit;

  const UnsubmittedContent(
      {super.key,
      required this.theme,
      required this.onUpload,
      this.submissionFile,
      required this.onSubmit,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        Text(
          'Submission',
          style: theme.textTheme.titleLarge,
        ),
        const Text("It seems that you haven't submitted the assignment yet."),
        const SizedBox(
          height: 40,
        ),
        AttachmentWidget(data: data, theme: theme, onUpload: onUpload),
        const SizedBox(
          height: 30,
        ),
        BlocListener<UploadSubmissionBloc, UploadSubmissionState>(
            listener: (context, state) {
              if (state is GetSubmissionFileResult && state.isSuccess) {
                final data = state.data;

                if (data == null) {
                  context.showErrorSnackBar(
                      message:
                          'There is something wrong with the submission file.');
                  return;
                }

                context
                    .read<UploadSubmissionBloc>()
                    .add(UploadEvent(data: state.data!));
              } else if (state is GetSubmissionFileResult && !state.isSuccess) {
                context.showErrorSnackBar(message: state.message);
              }

              if (state is UploadStateResult && state.isSuccess) {
                context.showSnackBar(
                    message: 'You have uploaded your assignment!',
                    backgroundColor: Colors.green);
              } else if (state is UploadStateResult && !state.isSuccess) {
                context.showErrorSnackBar(message: state.message);
              }
            },
            child: ElevatedButton(
                onPressed: submissionFile == null ? null : () => onSubmit(),
                child: const Text('Submit')))
      ],
    );
  }
}
