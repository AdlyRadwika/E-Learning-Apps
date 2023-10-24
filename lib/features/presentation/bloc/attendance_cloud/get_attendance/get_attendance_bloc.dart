import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/attendance/attendance_content.dart';
import 'package:final_project/features/domain/usecases/attendance_cloud/get_attendance_by_class.dart';

part 'get_attendance_event.dart';
part 'get_attendance_state.dart';

class GetAttendancesBloc
    extends Bloc<GetAttendancesEvent, GetAttendancesState> {
  final GetAttendancesByClassUseCase getAttendancesUseCase;

  GetAttendancesBloc({
    required this.getAttendancesUseCase,
  }) : super(GetAttendancesInitial()) {
    on<GetAttendancesByClassEvent>((event, emit) async {
      emit(GetAttendancesByClassLoading());

      final result = await getAttendancesUseCase.execute(classCode: event.classCode);

      emit(result.fold(
          (l) =>
              GetAttendancesByClassResult(isSuccess: false, message: l.message),
          (r) =>
              GetAttendancesByClassResult(isSuccess: true, attendances: r)));
    });
  }
}
