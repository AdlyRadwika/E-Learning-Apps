import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/assignment/submission.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/get_submission_file.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/upload_submission.dart';

part 'upload_submission_event.dart';
part 'upload_submission_state.dart';

class UploadSubmissionBloc
    extends Bloc<UploadSubmissionEvent, UploadSubmissionState> {
  final UploadSubmissionUseCase uploadSubmissionUseCase;
  final GetSubmissionFileUseCase getSubmissionFileUseCase;

  UploadSubmissionBloc({
    required this.uploadSubmissionUseCase,
    required this.getSubmissionFileUseCase,
  }) : super(UploadSubmissionInitial()) {
    on<UploadEvent>((event, emit) async {
      emit(UploadStateLoading());

      final result = await uploadSubmissionUseCase.execute(data: event.data);

      emit(result.fold(
          (l) => UploadStateResult(isSuccess: false, message: l.message),
          (r) => UploadStateResult(
                isSuccess: true,
              )));
    });
    on<GetSubmissionFileEvent>((event, emit) async {
      emit(GetSubmissionFileLoading());

      final result = await getSubmissionFileUseCase.execute(
          file: event.file,
          studentId: event.studentId,
          assignmentId: event.assignmentId);

      emit(result.fold(
          (l) => GetSubmissionFileResult(isSuccess: false, message: l.message),
          (r) => GetSubmissionFileResult(
                isSuccess: true,
                data: r,
              )));
    });
  }
}
