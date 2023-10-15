import 'package:uuid/uuid.dart';

class UuidServiceInit {
  static Uuid getService() {
    return const Uuid();
  }
}

class UuidService {
  final Uuid uuid;

  const UuidService(this.uuid);

  String generateClassCode() {
    final value = uuid.v4().substring(0, 6).toUpperCase();
    return value;
  }
}
