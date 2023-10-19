part of 'class_index_bloc.dart';

abstract class ClassIndexState {}

class ClassIndexInitial extends ClassIndexState {}

class GetClassesByIdLoading extends ClassIndexState {}

class GetClassesByIdResult extends ClassIndexState {
  final String message;
  final bool isSuccess;
  final Stream<QuerySnapshot<ClassModel>>? classesStream;

  GetClassesByIdResult({
    this.message = '',
    required this.isSuccess,
    this.classesStream,
  });
}

class GetEnrolledClassesByIdLoading extends ClassIndexState {}

class GetEnrolledClassesByIdResult extends ClassIndexState {
  final String message;
  final bool isSuccess;
  final Stream<QuerySnapshot<EnrolledClassModel>>? classesStream;

  GetEnrolledClassesByIdResult({
    this.message = '',
    required this.isSuccess,
    this.classesStream,
  });
}