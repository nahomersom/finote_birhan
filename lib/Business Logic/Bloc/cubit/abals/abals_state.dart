part of 'abals_cubit.dart';

enum AbalListStatus {
  initial,
  loading,
  success,
  error,
}

extension AbalListStatusx on AbalListStatus {
  bool get isInitial => this == AbalListStatus.initial;
  bool get isLoading => this == AbalListStatus.loading;
  bool get isSuccess => this == AbalListStatus.success;
  bool get hasError => this == AbalListStatus.error;
}

class AbalListState extends Equatable {
  final AbalListStatus abalsListStatus;
  final String errorMessage;
  final List<dynamic> abals;

  const AbalListState({
    this.abalsListStatus = AbalListStatus.initial,
    required this.errorMessage,
    List<dynamic>? abals,
  }) : abals = abals ?? const [];
  AbalListState copyWith(
      {List<dynamic>? abals,
      AbalListStatus? abalListStatus,
      required String errorMessage}) {
    return AbalListState(
        abals: abals ?? this.abals, errorMessage: errorMessage);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage, abals];
}
