import 'package:firebase_auth/firebase_auth.dart';
import 'package:hisnate_kifele/Data/Services/auth_service.dart';

class UserRepository{
   final FirbaseAuthService authService;

  UserRepository({required this.authService});
  Future<User> login(String email , String password) async => await authService.signInWithEmailAndPassword(email, password);


}