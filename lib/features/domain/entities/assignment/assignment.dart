import 'package:final_project/features/data/models/assignment/assignment_model.dart';

class Assignment {
  final String id;
  final String classCode;
  final String title;
  final String description;
  final String teacherId;
  final String deadline;
  final String updatedAt;
  final String createdAt;

  const Assignment(
      {required this.id,
      required this.title,
      required this.description,
      required this.teacherId,
      required this.deadline,
      required this.updatedAt,
      required this.createdAt,
      required this.classCode});

  AssignmentModel toModel() {
    return AssignmentModel(
        id: id,
        title: title,
        description: description,
        teacherId: teacherId,
        deadline: deadline,
        updatedAt: updatedAt,
        createdAt: createdAt,
        classCode: classCode);
  }
}
