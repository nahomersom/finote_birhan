part of 'abal_cubit.dart';

enum AbalStatus { initial, loading, success, error, registered, isRegistering }

extension AbalStatusx on AbalStatus {
  bool get isInitial => this == AbalStatus.initial;
  bool get isLoading => this == AbalStatus.loading;
  bool get isSuccess => this == AbalStatus.success;
  bool get isRegistered => this == AbalStatus.registered;
  bool get isRegistering => this == AbalStatus.isRegistering;
  bool get hasError => this == AbalStatus.error;
}

class AbalState extends Equatable {
  final AbalStatus abalStatus;
  final String errorMessage;
  final List<dynamic> kifiles;
  final List<dynamic> nestedKifiles;
  final List<AbalRegistrationModel> abals;
  final AbalRegistrationModel? selectedAbal; // Add selectedAbal

  const AbalState({
    this.abalStatus = AbalStatus.initial,
    this.errorMessage = '',
    List<dynamic>? kifiles,
    List<dynamic>? nestedKifiles,
    List<AbalRegistrationModel>? abals,
    this.selectedAbal, // Add selectedAbal to constructor
  })  : kifiles = kifiles ?? const [],
        nestedKifiles = nestedKifiles ?? const [],
        abals = abals ?? const [];

  AbalState copyWith({
    List<dynamic>? kifiles,
    List<dynamic>? nestedKifiles,
    List<AbalRegistrationModel>? abals,
    AbalRegistrationModel? selectedAbal, // Add selectedAbal to copyWith
    AbalStatus? abalStatus,
    String? errorMessage,
  }) {
    return AbalState(
      kifiles: kifiles ?? this.kifiles,
      nestedKifiles: nestedKifiles ?? this.nestedKifiles,
      abals: abals ?? this.abals,
      selectedAbal: selectedAbal ?? this.selectedAbal, // Update selectedAbal
      abalStatus: abalStatus ?? this.abalStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        abalStatus,
        errorMessage,
        kifiles,
        nestedKifiles,
        abals,
        selectedAbal, // Include selectedAbal in props
      ];
}
