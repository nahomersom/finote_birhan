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
  final List<dynamic> abals;

  const AbalState({
    this.abalStatus = AbalStatus.initial,
    this.errorMessage = '',
    List<dynamic>? kifiles,
    List<dynamic>? nestedKifiles,
    List<dynamic>? abals,
  })  : kifiles = kifiles ?? const [],
        nestedKifiles = nestedKifiles ?? const [],
        abals = abals ?? const [];

  AbalState copyWith({
    List<dynamic>? kifiles,
    List<dynamic>? nestedKifiles,
    List<dynamic>? abals,
    AbalStatus? abalStatus,
    String? errorMessage,
  }) {
    return AbalState(
      kifiles: kifiles ?? this.kifiles,
      nestedKifiles: nestedKifiles ?? this.nestedKifiles,
      abals: abals ?? this.abals,
      abalStatus: abalStatus ?? this.abalStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [abalStatus, errorMessage, kifiles, nestedKifiles, abals];
}
