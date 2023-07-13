import 'package:firebase_auth/firebase_auth.dart';
import 'package:hisnate_kifele/Data/Models/current_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../Data/Repositories/user.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationCubit({required this.userRepository})
      : super(const AuthenticationState(errorMessage: ''));

  Future login(String email, String password) async {
    emit(state.copyWith(
        status: AuthenticationStatus.unAuthenticated, errorMessage: ''));

    CurrentUser currentUser =
        CurrentUser(email: "email", name: "name", role: "role", token: "token");
    try {
      emit(state.copyWith(
          status: AuthenticationStatus.loading, errorMessage: ''));
      await userRepository.login(email, password).then((User user) {
        emit(state.copyWith(
            status: AuthenticationStatus.authenticated,
            user: currentUser,
            errorMessage: ""));
      });
    } catch (e) {
      emit(state.copyWith(
          status: AuthenticationStatus.error, errorMessage: e.toString()));
      throw Exception(e.toString());
    }
  }
}
