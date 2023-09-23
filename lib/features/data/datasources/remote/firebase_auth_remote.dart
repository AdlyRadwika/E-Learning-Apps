import 'package:final_project/common/error/exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthRemote {
  Future<User?> register(
      {required String email,
      required String password,
      required String userName,
      required String role});
  Future<void> login({required String email, required String password});
  Future<void> logout();
}

class FirebaseAuthRemoteImpl implements FirebaseAuthRemote {
  final auth = FirebaseAuth.instance;

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ServerException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ServerException('Wrong password provided for that user.');
      }
      throw ServerException(e.message ?? "Unknown exception (firebase)");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<User?> register(
      {required String email,
      required String password,
      required String userName,
      required String role}) async {
    try {
      final response = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return response.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ServerException('Password is too weak');
      } else if (e.code == 'email-already-in-use') {
        throw ServerException('The account already exists for that email.');
      }
      throw ServerException(e.message ?? "Unknown exception (firebase)");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? "Unknown exception (firebase)");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
