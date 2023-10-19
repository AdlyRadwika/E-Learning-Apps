import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/data/models/assignment/assignment_model.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/get_assignments_by_class.dart';

part 'get_assignment_event.dart';
part 'get_assignment_state.dart';

class GetAssignmentsBloc
    extends Bloc<GetAssignmentsEvent, GetAssignmentsState> {
  final GetAssignmentsByClassUseCase getAssignmentsUseCase;

  GetAssignmentsBloc({
    required this.getAssignmentsUseCase,
  }) : super(GetAssignmentsInitial()) {
    on<GetAssignmentsByClassEvent>((event, emit) async {
      emit(GetAssignmentsByClassLoading());

      final result = await getAssignmentsUseCase.execute(classCode: event.classCode);

      emit(result.fold(
          (l) =>
              GetAssignmentsByClassResult(isSuccess: false, message: l.message),
          (r) =>
              GetAssignmentsByClassResult(isSuccess: true, assignmentStream: r)));
    });
  }
}
