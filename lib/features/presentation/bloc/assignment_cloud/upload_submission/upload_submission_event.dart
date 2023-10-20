part of 'upload_submission_bloc.dart';

abstract class UploadSubmissionEvent {}

class UploadEvent extends UploadSubmissionEvent {
  final Submission data;

  UploadEvent({
    required this.data,
  });
}

class GetSubmissionFileEvent extends UploadSubmissionEvent {
  final File file;
  final String studentId;
  final String assignmentId;

  GetSubmissionFileEvent(
      {required this.file,
      required this.studentId,
      required this.assignmentId});
}
