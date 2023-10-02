class User {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String imageUrl;
  final List imageData;
  final String updatedAt;
  final String createdAt;

  const User(
      {required this.name,
      required this.email,
      required this.imageUrl,
      required this.imageData,
      required this.role, 
      required this.updatedAt,
      required this.createdAt,
      required this.uid});
}
