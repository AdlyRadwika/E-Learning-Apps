part of 'upload_submission_bloc.dart';

abstract class UploadSubmissionState {}

class UploadSubmissionInitial extends UploadSubmissionState {}

class UploadStateLoading extends UploadSubmissionState {}

class UploadStateResult extends UploadSubmissionState {
  final String message;
  final bool isSuccess;

  UploadStateResult({
    this.message = '',
    required this.isSuccess,
  });
}

class GetSubmissionFileLoading extends UploadSubmissionState {}

class GetSubmissionFileResult extends UploadSubmissionState {
  final String message;
  final bool isSuccess;
  final Submission? data;

  GetSubmissionFileResult({
    this.message = '',
    required this.isSuccess,
    this.data,
  });
}
