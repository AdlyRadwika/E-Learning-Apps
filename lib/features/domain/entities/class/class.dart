class Class {
  final String code;
  final String title;
  final String description;
  final String teacherId;
  final String updatedAt;
  final String createdAt;

  const Class(
      {required this.title,
      required this.description,
      required this.teacherId,
      required this.updatedAt,
      required this.createdAt,
      required this.code});
}
