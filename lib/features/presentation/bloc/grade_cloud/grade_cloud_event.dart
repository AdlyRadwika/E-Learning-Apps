part of 'grade_cloud_bloc.dart';

abstract class GradeCloudEvent {}

class InsertGradeEvent extends GradeCloudEvent {
  final Grade data;

  InsertGradeEvent({
    required this.data,
  });
}

class UpdateGradeEvent extends GradeCloudEvent {
  final String gradeId;
  final int grade;

  UpdateGradeEvent({
    required this.gradeId,
    required this.grade,
  });
}
