import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/get_assignment_schedules.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/get_teacher_schedules.dart';

part 'get_assignment_schedule_event.dart';
part 'get_assignment_schedule_state.dart';

class GetScheduleBloc extends Bloc<GetScheduleEvent, GetScheduleState> {
  final GetAssignmentsSchedulesUseCase getAssignmentsUseCase;
  final GetTeacherSchedulesUseCase getTeacherScheduleUseCase;

  GetScheduleBloc({
    required this.getAssignmentsUseCase,
    required this.getTeacherScheduleUseCase,
  }) : super(GetScheduleInitial()) {
    on<GetAssignmentsSchedulesEvent>((event, emit) async {
      emit(GetScheduleLoading());

      final result =
          await getAssignmentsUseCase.execute(studentId: event.studentId);

      emit(result.fold(
          (l) => GetAssignmentsSchedulesResult(
              isSuccess: false, message: l.message),
          (r) => GetAssignmentsSchedulesResult(
              isSuccess: true, assignments: r)));
    });
    on<GetTeacherScheduleEvent>((event, emit) async {
      emit(GetScheduleLoading());

      final result =
          await getTeacherScheduleUseCase.execute(teacherId: event.teacherId);

      emit(result.fold(
          (l) => GetTeacherScheduleResult(
              isSuccess: false, message: l.message),
          (r) => GetTeacherScheduleResult(
              isSuccess: true, assignments: r)));
    });
  }
}
