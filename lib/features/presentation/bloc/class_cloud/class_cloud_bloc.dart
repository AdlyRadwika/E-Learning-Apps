import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/usecases/class_cloud/create_class.dart';
import 'package:final_project/features/domain/usecases/class_cloud/join_class.dart';

part 'class_cloud_event.dart';
part 'class_cloud_state.dart';

class ClassCloudBloc extends Bloc<ClassCloudEvent, ClassCloudState> {
  final CreateClassUseCase createClassUseCase;
  final JoinClassUseCase joinClassUseCase;

  ClassCloudBloc({
    required this.createClassUseCase,
    required this.joinClassUseCase,
  }) : super(ClassCloudInitial()) {
    on<CreateClassEvent>((event, emit) async {
      emit(CreateClassLoading());

      final result = await createClassUseCase.execute(
          code: event.code,
          title: event.title,
          description: event.description,
          teacherId: event.teacherId);

      emit(result.fold(
          (l) => CreateClassResult(isSuccess: false, message: l.message),
          (r) => CreateClassResult(isSuccess: true)));
    });
    on<JoinClassEvent>((event, emit) async {
      emit(JoinClassLoading());

      final result =
          await joinClassUseCase.execute(code: event.code, uid: event.uid);

      emit(result.fold(
          (l) => JoinClassResult(isSuccess: false, message: l.message),
          (r) => JoinClassResult(isSuccess: true)));
    });
  }
}
