import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/class/class_user.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_class_teacher.dart';

part 'get_class_teacher_event.dart';
part 'get_class_teacher_state.dart';

class GetClassTeacherBloc extends Bloc<GetClassTeacherEvent, GetClassTeacherState> {
  final GetClassTeacherUseCase getClassTeacherUseCase;

  GetClassTeacherBloc({
    required this.getClassTeacherUseCase,
  }) : super(GetClassTeacherInitial()) {
    on<FetchTeacherEvent>((event, emit) async {
      emit(GetClassTeacherLoading());

      final result =
          await getClassTeacherUseCase.execute(classCode: event.classCode);

      emit(result.fold(
          (l) => GetClassTeacherResult(
              isSuccess: false, message: l.message),
          (r) => GetClassTeacherResult(isSuccess: true, teacher: r)));
    });
  }
}
