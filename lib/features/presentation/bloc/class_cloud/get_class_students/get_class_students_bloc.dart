import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/class/class_user.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_class_students.dart';

part 'get_class_students_event.dart';
part 'get_class_students_state.dart';

class GetClassStudentsBloc extends Bloc<GetClassStudentsEvent, GetClassStudentsState> {
  final GetClassStudentsUseCase getClassStudentsUseCase;

  GetClassStudentsBloc({
    required this.getClassStudentsUseCase,
  }) : super(GetClassStudentsInitial()) {
    on<FetchStudentsEvent>((event, emit) async {
      emit(GetClassStudentsLoading());

      final result =
          await getClassStudentsUseCase.execute(classCode: event.classCode);

      emit(result.fold(
          (l) => GetClassStudentsResult(
              isSuccess: false, message: l.message),
          (r) => GetClassStudentsResult(isSuccess: true, students: r)));
    });
  }
}
