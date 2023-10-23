import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/assignment/students_assignment_status.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/get_unsubmitted_assignments.dart';

part 'get_unsubmitted_assignment_event.dart';
part 'get_unsubmitted_assignment_state.dart';

class GetUnsubmittedAssignmentsBloc
    extends Bloc<GetUnsubmittedAssignmentsEvent, GetUnsubmittedAssignmentsState> {
  final GetUnsubmittedAssignmentsUseCase getUnsubmittedAssignmentsUseCase;

  GetUnsubmittedAssignmentsBloc({
    required this.getUnsubmittedAssignmentsUseCase,
  }) : super(GetUnsubmittedAssignmentsInitial()) {
    on<FetchUnsubmittedAssignmentEvent>((event, emit) async {
      emit(FetchUnsubmittedAssignmentLoading());

      final result = await getUnsubmittedAssignmentsUseCase.execute(
          assignmentId: event.assignmentId);

      emit(result.fold(
          (l) => FetchUnsubmittedAssignmentResult(
              isSuccess: false, message: l.message),
          (r) => FetchUnsubmittedAssignmentResult(isSuccess: true, data: r)));
    });
  }
}
