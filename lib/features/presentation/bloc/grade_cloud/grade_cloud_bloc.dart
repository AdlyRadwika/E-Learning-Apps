import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/grade/grade.dart';
import 'package:final_project/features/domain/usecases/grade_cloud/insert_grade.dart';
import 'package:final_project/features/domain/usecases/grade_cloud/update_grade.dart';

part 'grade_cloud_event.dart';
part 'grade_cloud_state.dart';

class GradeCloudBloc extends Bloc<GradeCloudEvent, GradeCloudState> {
  final InsertGradeUseCase insertUseCase;
  final UpdateGradeUseCase updateUseCase;

  GradeCloudBloc({
    required this.insertUseCase,
    required this.updateUseCase,
  }) : super(GradeCloudInitial()) {
    on<InsertGradeEvent>((event, emit) async {
      emit(InsertGradeLoading());

      final result = await insertUseCase.execute(data: event.data);

      emit(result.fold(
          (l) => InsertGradeResult(isSuccess: false, message: l.message),
          (r) => InsertGradeResult(isSuccess: true)));
    });
    on<UpdateGradeEvent>((event, emit) async {
      emit(UpdateGradeLoading());

      final result = await updateUseCase.execute(
          gradeId: event.gradeId, grade: event.grade);

      emit(result.fold(
          (l) => UpdateGradeResult(isSuccess: false, message: l.message),
          (r) => UpdateGradeResult(isSuccess: true)));
    });
  }
}
