import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/data/models/assignment/submission_model.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/get_submission_status.dart';

part 'get_submission_event.dart';
part 'get_submission_state.dart';

class GetSubmissionsBloc
    extends Bloc<GetSubmissionsEvent, GetSubmissionsState> {
  final GetSubmissionStatusUseCase getSubmissionsUseCase;

  GetSubmissionsBloc({
    required this.getSubmissionsUseCase,
  }) : super(GetSubmissionsInitial()) {
    on<GetSubmissionsStatusEvent>((event, emit) async {
      emit(GetSubmissionsStatusLoading());

      final result = await getSubmissionsUseCase.execute(
          studentId: event.studentId, assignmentId: event.assignmentId);

      emit(result.fold(
          (l) =>
              GetSubmissionsStatusResult(isSuccess: false, message: l.message),
          (r) => GetSubmissionsStatusResult(isSuccess: true, statusStream: r)));
    });
  }
}
