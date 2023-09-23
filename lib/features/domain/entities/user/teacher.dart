class Teacher {
  final String uid;
  final String name;
  final String email;
  final String imageUrl;
  final DateTime updatedAt;
  final DateTime createdAt;

  const Teacher(
      {required this.name,
      required this.email,
      required this.imageUrl,
      required this.updatedAt,
      required this.createdAt,
      required this.uid});
}
