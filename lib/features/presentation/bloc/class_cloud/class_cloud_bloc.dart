import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/class/class.dart';
import 'package:final_project/features/domain/entities/class/class_user.dart';
import 'package:final_project/features/domain/entities/class/enrolled_class.dart';
import 'package:final_project/features/domain/usecases/class_cloud/create_class.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_class_students.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_class_teacher.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_classes_by_id.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_enrolled_classes_by_id.dart';
import 'package:final_project/features/domain/usecases/class_cloud/join_class.dart';

part 'class_cloud_event.dart';
part 'class_cloud_state.dart';

class ClassCloudBloc extends Bloc<ClassCloudEvent, ClassCloudState> {
  final CreateClassUseCase createClassUseCase;
  final JoinClassUseCase joinClassUseCase;
  final GetClassesByIdUseCase getClassesByIdUseCase;
  final GetEnrolledClassesByIdUseCase getEnrolledClassesByIdUseCase;
  final GetClassTeacherUseCase getClassTeacherUseCase;
  final GetClassStudentsUseCase getClassStudentsUseCase;

  ClassCloudBloc({
    required this.createClassUseCase,
    required this.joinClassUseCase,
    required this.getClassesByIdUseCase,
    required this.getEnrolledClassesByIdUseCase,
    required this.getClassTeacherUseCase,
    required this.getClassStudentsUseCase,
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
    on<GetClassesByIdEvent>((event, emit) async {
      emit(GetClassesByIdLoading());

      final result = await getClassesByIdUseCase.execute(uid: event.uid);

      emit(result.fold(
          (l) => GetClassesByIdResult(isSuccess: false, message: l.message),
          (r) => GetClassesByIdResult(isSuccess: true, classes: r)));
    });
    on<GetEnrolledClassesByIdEvent>((event, emit) async {
      emit(GetEnrolledClassesByIdLoading());

      final result =
          await getEnrolledClassesByIdUseCase.execute(uid: event.uid);

      emit(result.fold(
          (l) => GetEnrolledClassesByIdResult(
              isSuccess: false, message: l.message),
          (r) => GetEnrolledClassesByIdResult(isSuccess: true, classes: r)));
    });
    on<GetClassTeacherEvent>((event, emit) async {
      emit(GetClassTeacherLoading());

      final result =
          await getClassTeacherUseCase.execute(classCode: event.classCode);

      emit(result.fold(
          (l) => GetClassTeacherResult(
              isSuccess: false, message: l.message),
          (r) => GetClassTeacherResult(isSuccess: true, teacher: r)));
    });
    on<GetClassStudentsEvent>((event, emit) async {
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
