import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirbaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      // await InternetAddress.lookup('example.com');
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("userrrrrrrr/n");
      print(result.user);
      if (result.user != null) {
        return result.user!;
      } else {
        throw Exception("invalid login");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw Exception('network request failed please try agnain');
      } else {
        throw Exception('invalid email or password please try again');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> signUpWithEmailAndPassword(
      String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result.user?.uid;
  }

  Future<void> signOut(context) async {
    try {
      await SharedPreferences.getInstance().then((value) => value.clear());
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
