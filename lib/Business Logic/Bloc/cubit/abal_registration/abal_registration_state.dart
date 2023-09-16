part of 'abal_registration_cubit.dart';

enum AbalRegistrationStatus {
  initial,
  loading,
  success,
  error,
  registered,
  isRegistering
}

extension AbalRegistrationStatusx on AbalRegistrationStatus {
  bool get isInitial => this == AbalRegistrationStatus.initial;
  bool get isLoading => this == AbalRegistrationStatus.loading;
  bool get isSuccess => this == AbalRegistrationStatus.success;
  bool get isRegistered => this == AbalRegistrationStatus.registered;
  bool get isRegistering => this == AbalRegistrationStatus.isRegistering;

  bool get hasError => this == AbalRegistrationStatus.error;
}

class AbalRegistrationState extends Equatable {
  final AbalRegistrationStatus abalRegistrationStatus;
  final String errorMessage;
  final List<dynamic> kifiles;
  final List<dynamic> nestedKifiles;

  const AbalRegistrationState(
      {this.abalRegistrationStatus = AbalRegistrationStatus.initial,
      required this.errorMessage,
      List<dynamic>? kifiles,
      List<dynamic>? nestedKifiles})
      : kifiles = kifiles ?? const [],
        nestedKifiles = nestedKifiles ?? const [];
  AbalRegistrationState copyWith(
      {List<dynamic>? kifiles,
      List<dynamic>? nestedKifiles,
      AbalRegistrationStatus? updatedAbalRegistrationStatus,
      required String errorMessage}) {
    return AbalRegistrationState(
        kifiles: kifiles ?? this.kifiles,
        nestedKifiles: nestedKifiles ?? this.nestedKifiles,
        abalRegistrationStatus:
            updatedAbalRegistrationStatus ?? abalRegistrationStatus,
        errorMessage: errorMessage);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage, abalRegistrationStatus, kifiles];
}
