part of 'abal_registration_cubit.dart';

enum AbalRegistrationStatus { initial, loading,success ,error }

extension AbalRegistrationStatusx on AbalRegistrationStatus {
  bool get isInitial => this == AbalRegistrationStatus.initial;
  bool get isLoading => this == AbalRegistrationStatus.loading;
  bool get isSuccess => this == AbalRegistrationStatus.success;
  bool get hasError => this == AbalRegistrationStatus.error;
}


 class AbalRegistrationState extends Equatable {
  final AbalRegistrationStatus abalRegistrationStatus;
  final String errorMessage;
  const AbalRegistrationState({
    this.abalRegistrationStatus = AbalRegistrationStatus.initial,
    required this.errorMessage,
  });
  AbalRegistrationState copyWith(
      {
        AbalRegistrationStatus? updatedAbalRegistrationStatus,
        required String errorMessage}) {
    return AbalRegistrationState(
        abalRegistrationStatus: updatedAbalRegistrationStatus ?? abalRegistrationStatus, errorMessage: errorMessage);
  }
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
