part of 'authentication_cubit.dart';

enum AuthenticationStatus {
  unAuthenticated,
  loading,
  authenticated,
  error,
  codeSent
}

extension AuthenticationStatusx on AuthenticationStatus {
  bool get isLoading => this == AuthenticationStatus.loading;
  bool get authenticated => this == AuthenticationStatus.authenticated;
  bool get unAuthenticated => this == AuthenticationStatus.unAuthenticated;
  bool get codeSent => this == AuthenticationStatus.codeSent;
  bool get hasError => this == AuthenticationStatus.error;
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus authStatus;
  final CurrentUser? currentUser;
  final String errorMessage;
  final String? verificationId;

  const AuthenticationState({
    this.authStatus = AuthenticationStatus.unAuthenticated,
    required this.errorMessage,
    this.currentUser,
    this.verificationId
  });

  @override
  List<Object?> get props => [authStatus, currentUser , verificationId];

  AuthenticationState copyWith(
      {AuthenticationStatus? status,
      CurrentUser? user,
      String? verificationId,
      required String errorMessage}) {
    return AuthenticationState(
        authStatus: status ?? authStatus,
        currentUser: user,
        verificationId: verificationId,
        errorMessage: errorMessage);
  }
}
