class EnrolledClass {
  final String code;
  final String title;
  final String description;
  final String studentId;
  final String updatedAt;
  final String createdAt;

  const EnrolledClass(
      {required this.title,
      required this.description,
      required this.studentId,
      required this.updatedAt,
      required this.createdAt,
      required this.code});
}
