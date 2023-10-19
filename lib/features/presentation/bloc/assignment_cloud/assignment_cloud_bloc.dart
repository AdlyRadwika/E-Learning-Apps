import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/delete_assignment.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/insert_assignment.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/update_assignment.dart';

part 'assignment_cloud_event.dart';
part 'assignment_cloud_state.dart';

class AssignmentCloudBloc
    extends Bloc<AssignmentCloudEvent, AssignmentCloudState> {
  final InsertAssignmentUseCase insertUseCase;
  final DeleteAssignmentUseCase deleteUseCase;
  final UpdateAssignmentUseCase updateUseCase;

  AssignmentCloudBloc({
    required this.insertUseCase,
    required this.deleteUseCase,
    required this.updateUseCase,
  }) : super(AssignmentCloudInitial()) {
    on<InsertAssignmentEvent>((event, emit) async {
      emit(InsertAssignmentLoading());

      final result = await insertUseCase.execute(data: event.data);

      emit(result.fold(
          (l) => InsertAssignmentResult(isSuccess: false, message: l.message),
          (r) => InsertAssignmentResult(isSuccess: true)));
    });
    on<DeleteAssignmentEvent>((event, emit) async {
      emit(DeleteAssignmentLoading());

      final result = await deleteUseCase.execute(assignmentId: event.id);

      emit(result.fold(
          (l) => DeleteAssignmentResult(isSuccess: false, message: l.message),
          (r) => DeleteAssignmentResult(isSuccess: true)));
    });
    on<UpdateAssignmentEvent>((event, emit) async {
      emit(UpdateAssignmentLoading());

      final result = await updateUseCase.execute(data: event.data);

      emit(result.fold(
          (l) => UpdateAssignmentResult(isSuccess: false, message: l.message),
          (r) => UpdateAssignmentResult(isSuccess: true)));
    });
  }
}
