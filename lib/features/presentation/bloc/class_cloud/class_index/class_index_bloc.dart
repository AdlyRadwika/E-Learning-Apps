import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/data/models/class/class_model.dart';
import 'package:final_project/features/data/models/class/enrolled_class_model.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_classes_by_id.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_enrolled_classes_by_id.dart';

part 'class_index_event.dart';
part 'class_index_state.dart';

class ClassIndexBloc extends Bloc<ClassIndexEvent, ClassIndexState> {
  final GetClassesByIdUseCase getClassesByIdUseCase;
  final GetEnrolledClassesByIdUseCase getEnrolledClassesByIdUseCase;

  ClassIndexBloc({
    required this.getClassesByIdUseCase,
    required this.getEnrolledClassesByIdUseCase,
  }) : super(ClassIndexInitial()) {
    on<GetClassesByIdEvent>((event, emit) async {
      emit(GetClassesByIdLoading());

      final result = await getClassesByIdUseCase.execute(uid: event.uid);

      emit(result.fold(
          (l) => GetClassesByIdResult(isSuccess: false, message: l.message),
          (r) => GetClassesByIdResult(isSuccess: true, classesStream: r)));
    });
    on<GetEnrolledClassesByIdEvent>((event, emit) async {
      emit(GetEnrolledClassesByIdLoading());

      final result =
          await getEnrolledClassesByIdUseCase.execute(uid: event.uid);

      emit(result.fold(
          (l) => GetEnrolledClassesByIdResult(
              isSuccess: false, message: l.message),
          (r) => GetEnrolledClassesByIdResult(isSuccess: true, classesStream: r)));
    });
  }
}
