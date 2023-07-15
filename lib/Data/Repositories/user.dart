import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hisnate_kifele/Data/Services/auth_service.dart';
import 'package:hisnate_kifele/Data/Services/firebase_service.dart';

class UserRepository {
  final FirbaseAuthService authService;
  final FirestoreService firestoreService;

  UserRepository({required this.authService, required this.firestoreService});
  Future login(String phone) async => await authService.signInWithPhone(phone);
  Future<PhoneAuthCredential?> verifyOtp(
          String verificationId, String otpCode) async =>
      await authService.verifySmsCode(verificationId, otpCode);
  Future<DocumentSnapshot<Map<String, dynamic>>> findUser(String userId) async =>
      await firestoreService.getDocumentbyId("systemUsers", userId);

  Future logout() async => await authService.signOut();
}
