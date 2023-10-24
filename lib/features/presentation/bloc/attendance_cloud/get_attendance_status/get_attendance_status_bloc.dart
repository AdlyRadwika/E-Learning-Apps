import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/data/models/attendance/attendance_model.dart';
import 'package:final_project/features/domain/usecases/attendance_cloud/get_attendance_status.dart';

part 'get_attendance_status_event.dart';
part 'get_attendance_status_state.dart';

class GetAttendanceStatusBloc
    extends Bloc<GetAttendanceStatusEvent, GetAttendanceStatusState> {
  final GetAttendanceStatusUseCase getAttendanceStatusUseCase;

  GetAttendanceStatusBloc({
    required this.getAttendanceStatusUseCase,
  }) : super(GetAttendanceStatusInitial()) {
    on<GetAttendanceStatusByStudentEvent>((event, emit) async {
      emit(GetAttendanceStatusByStudentLoading());

      final result = await getAttendanceStatusUseCase.execute(
          classCode: event.classCode, studentId: event.studentId);

      emit(result.fold(
          (l) => GetAttendanceStatusByStudentResult(
              isSuccess: false, message: l.message),
          (r) => GetAttendanceStatusByStudentResult(
              isSuccess: true, statusStream: r)));
    });
  }
}
