
class AttendanceModel {
  final String id;
  final String classCode;
  final String content;
  final String teacherId;
  final String updatedAt;
  final String createdAt;

  const AttendanceModel(
      {required this.id,
      required this.content,
      required this.teacherId,
      required this.updatedAt,
      required this.createdAt,
      required this.classCode});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        classCode: json["class_code"],
        id: json["id"],
        content: json["content"],
        teacherId: json["teacher_id"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "class_code": classCode,
        "content": content,
        "teacher_id": teacherId,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };

  // Attendance toEntity() {
  //   return Attendance(
  //       id: id,
  //       content: content,
  //       teacherId: teacherId,
  //       updatedAt: updatedAt,
  //       createdAt: createdAt,
  //       classCode: classCode);
  // }
}
