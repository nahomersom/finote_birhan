import 'package:firebase_auth/firebase_auth.dart';

class LoginResponse {
  String status;
  User? user;
  FirebaseAuthException? exception;
  String? verificationId;
  LoginResponse(
      {required this.status, this.user, this.exception, this.verificationId});
}
