class User {
  final String uid;
  final String name;
  final String email;
  final String imageUrl;
  final List imageData;
  final DateTime updatedAt;
  final DateTime createdAt;

  const User(
      {required this.name,
      required this.email,
      required this.imageUrl,
      required this.imageData,
      required this.updatedAt,
      required this.createdAt,
      required this.uid});
}
