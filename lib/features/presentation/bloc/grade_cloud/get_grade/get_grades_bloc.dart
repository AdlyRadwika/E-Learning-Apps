import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/grade/grade_content.dart';
import 'package:final_project/features/domain/usecases/grade_cloud/get_grades_by_class.dart';

part 'get_grades_event.dart';
part 'get_grades_state.dart';

class GetGradesBloc extends Bloc<GetGradesEvent, GetGradesState> {
  final GetGradesByStudentUseCase getGradesUseCase;

  GetGradesBloc({
    required this.getGradesUseCase,
  }) : super(GetGradesInitial()) {
    on<GetGradesByStudentEvent>((event, emit) async {
      emit(GetGradesByStudentLoading());

      final result = await getGradesUseCase.execute(
          classCode: event.classCode, studentId: event.studentId);

      emit(result.fold(
          (l) => GetGradesByStudentResult(isSuccess: false, message: l.message),
          (r) => GetGradesByStudentResult(isSuccess: true, grade: r)));
    });
  }
}
