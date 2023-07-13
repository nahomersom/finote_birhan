part of 'authentication_cubit.dart';

enum AuthenticationStatus { unAuthenticated, loading, authenticated, error }

extension AuthenticationStatusx on AuthenticationStatus {
  bool get isLoading => this == AuthenticationStatus.loading;
  bool get authenticated => this == AuthenticationStatus.authenticated;
  bool get unAuthenticated => this == AuthenticationStatus.unAuthenticated;
  bool get hasError => this == AuthenticationStatus.error;
}

class AuthenticationState extends Equatable {
  
  final AuthenticationStatus authStatus;
  final CurrentUser? currentUser;
  final String errorMessage;

  const AuthenticationState({
    this.authStatus = AuthenticationStatus.unAuthenticated,
    required this.errorMessage,
    this.currentUser,
  });

  @override
  List<Object?> get props => [authStatus, currentUser];

  AuthenticationState copyWith(
      {AuthenticationStatus? status,
      CurrentUser? user,
      required String errorMessage}) {
    return AuthenticationState(
        authStatus: status ?? authStatus,
        currentUser: user,
        errorMessage: errorMessage);
  }
}
