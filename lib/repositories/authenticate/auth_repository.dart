import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<UserCredential> signInUser(
      {required String email, required String password});

  Future<UserCredential> createUser(
      {required String email, required String password});
}

class AuthRepository extends IAuthRepository {
  @override
  Future<UserCredential> createUser(
      {required String email, required String password}) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserCredential> signInUser(
      {required String email, required String password}) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}