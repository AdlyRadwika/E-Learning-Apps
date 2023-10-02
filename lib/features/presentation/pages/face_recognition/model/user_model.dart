import 'dart:convert';

class UserDB {
  String user;
  String password;
  List modelData;

  UserDB({
    required this.user,
    required this.password,
    required this.modelData,
  });

  static UserDB fromMap(Map<String, dynamic> user) {
    return UserDB(
      user: user['user'],
      password: user['password'],
      modelData: jsonDecode(user['model_data']),
    );
  }

  toMap() {
    return {
      'user': user,
      'password': password,
      'model_data': jsonEncode(modelData),
    };
  }
}