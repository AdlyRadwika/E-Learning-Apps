import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/assignment/students_assignment_status.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/get_submitted_assignments.dart';

part 'get_submitted_assignment_event.dart';
part 'get_submitted_assignment_state.dart';

class GetSubmittedAssignmentsBloc
    extends Bloc<GetSubmittedAssignmentsEvent, GetSubmittedAssignmentsState> {
  final GetSubmittedAssignmentsUseCase getSubmittedAssignmentsUseCase;

  GetSubmittedAssignmentsBloc({
    required this.getSubmittedAssignmentsUseCase,
  }) : super(GetSubmittedAssignmentsInitial()) {
    on<FetchSubmittedAssignmentEvent>((event, emit) async {
      emit(FetchSubmittedAssignmentLoading());

      final result = await getSubmittedAssignmentsUseCase.execute(
          assignmentId: event.assignmentId);

      emit(result.fold(
          (l) => FetchSubmittedAssignmentResult(
              isSuccess: false, message: l.message),
          (r) => FetchSubmittedAssignmentResult(isSuccess: true, data: r)));
    });
  }
}
