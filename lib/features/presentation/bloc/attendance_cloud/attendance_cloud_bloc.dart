import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/attendance/attendance.dart';
import 'package:final_project/features/domain/usecases/attendance_cloud/insert_attendance.dart';

part 'attendance_cloud_event.dart';
part 'attendance_cloud_state.dart';

class AttendanceCloudBloc
    extends Bloc<AttendanceCloudEvent, AttendanceCloudState> {
  final InsertAttendanceUseCase insertUseCase;

  AttendanceCloudBloc({
    required this.insertUseCase,
  }) : super(AttendanceCloudInitial()) {
    on<InsertAttendanceEvent>((event, emit) async {
      emit(InsertAttendanceLoading());

      final result = await insertUseCase.execute(
          data: event.data);

      emit(result.fold(
          (l) => InsertAttendanceResult(isSuccess: false, message: l.message),
          (r) => InsertAttendanceResult(isSuccess: true)));
    });
  }
}
