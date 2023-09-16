import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hisnate_kifele/Data/Models/current_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../Data/Repositories/user.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final UserRepository userRepository;
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthenticationCubit({required this.userRepository})
      : super(const AuthenticationState(errorMessage: ''));

  Future login(String phone) async {
    emit(state.copyWith(
        status: AuthenticationStatus.unAuthenticated, errorMessage: ''));

    CurrentUser currentUser =
        CurrentUser(phone: "phone", name: "name", role: "role", token: "token");
    try {
      emit(state.copyWith(
          status: AuthenticationStatus.loading, errorMessage: ''));
      print("initiating send");
      // await userRepository.login(phone).then((res) {
      //   switch (res.status) {
      //     case "authenticated":
      //       emit(state.copyWith(
      //           status: AuthenticationStatus.authenticated,
      //           user: currentUser,
      //           errorMessage: ""));
      //       break;
      //     case "verification-failed":
      //       if (res.exception.code == "invalid-phone-number") {
      //         throw Exception("invalid phone number");
      //       } else {
      //         throw Exception("something went wrong : ${res.exception.code}");
      //       }
      //     case "code-sent":
      //       print("volaaa");
      //       emit(state.copyWith(
      //           status: AuthenticationStatus.codeSent,
      //           verificationId: res.verificationId,
      //           errorMessage: ""));
      //       break;
      //   }
      // });

      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY
          // Sign the user in (or link) with the auto-generated credential
          print("compeleted");
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          print("userId -----${userCredential}");
          var systemUser =
              await userRepository.findUser(userCredential.user!.uid);

          if (systemUser != null) {
            emit(state.copyWith(
                status: AuthenticationStatus.authenticated,
                user: currentUser,
                errorMessage: ""));
          } else {
            emit(state.copyWith(
                status: AuthenticationStatus.error,
                errorMessage: "Invalid login"));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print("failed");
          String errorMessage;
          if (e.code == "invalid-phone-number") {
            errorMessage = "invalid phone number";
          } else {
            errorMessage = "something went wrong : ${e.code}";
          }
          emit(state.copyWith(
              status: AuthenticationStatus.error, errorMessage: e.toString()));
        },
        codeSent: (String verificationId, int? resendToken) {
          print("code sent");
          emit(state.copyWith(
              status: AuthenticationStatus.codeSent,
              verificationId: verificationId,
              errorMessage: ""));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("any error");
      emit(state.copyWith(
          status: AuthenticationStatus.error, errorMessage: e.toString()));
      throw Exception(e.toString());
    }
  }

  Future verifyOtp(
    String verificationId,
    String otpCode,
  ) async {
    CurrentUser currentUser =
        CurrentUser(phone: "phone", name: "name", role: "role", token: "token");
    try {
      emit(state.copyWith(
          status: AuthenticationStatus.loading, errorMessage: ''));

      PhoneAuthCredential? phoneCredential =
          await userRepository.verifyOtp(verificationId, otpCode);
      if (phoneCredential == null) {
        emit(state.copyWith(
            status: AuthenticationStatus.error,
            verificationId: verificationId,
            errorMessage: "Invalid login"));
      } else {
        UserCredential userCredential =
            await auth.signInWithCredential(phoneCredential);
        //phone is not registered
        if (userCredential.additionalUserInfo!.isNewUser) {
          await auth.currentUser!.delete();
          emit(state.copyWith(
              status: AuthenticationStatus.error,
              errorMessage:
                  "Invalid login:/n You must first Register to login"));
        } else {
          var snapshot =
              await userRepository.findUser(userCredential.user!.uid);

          if (snapshot.exists) {
            emit(state.copyWith(
                status: AuthenticationStatus.authenticated,
                user: currentUser,
                errorMessage: ""));
          } else {
            await userRepository.logout();
            emit(state.copyWith(
                status: AuthenticationStatus.error,
                errorMessage: "Invalid login"));
          }
        }
      }
    } catch (e) {
      emit(state.copyWith(
          status: AuthenticationStatus.error,
          errorMessage: e.toString().split("]").last,
          verificationId: verificationId));
    }
  }
}
