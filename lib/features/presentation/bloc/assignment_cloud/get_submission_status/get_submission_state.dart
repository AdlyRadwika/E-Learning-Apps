part of 'get_submission_bloc.dart';

abstract class GetSubmissionsState {}

class GetSubmissionsInitial extends GetSubmissionsState {}

class GetSubmissionsStatusLoading extends GetSubmissionsState {}

class GetSubmissionsStatusResult extends GetSubmissionsState {
  final String message;
  final bool isSuccess;
  final Stream<QuerySnapshot<SubmissionModel>>? statusStream;

  GetSubmissionsStatusResult({
    this.message = '',
    required this.isSuccess,
    this.statusStream,
  });
}
