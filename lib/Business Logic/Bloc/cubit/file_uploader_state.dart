part of 'file_uploader_cubit.dart';

enum FileUploaderStatus { initial, paused, downloading, stopped, done, error }

extension FileUploaderStatusx on FileUploaderStatus {
  bool get isInitial => this == FileUploaderStatus.initial;
  bool get isPaused => this == FileUploaderStatus.paused;
  bool get isDownloading => this == FileUploaderStatus.downloading;
  bool get isStopped => this == FileUploaderStatus.stopped;
  bool get isDone => this == FileUploaderStatus.done;
  bool get hasError => this == FileUploaderStatus.error;
}


 class FileUploaderState extends Equatable {
  final FileUploaderStatus uploadState;
  final String errorMessage;
  const FileUploaderState({
    this.uploadState = FileUploaderStatus.initial,
    required this.errorMessage,
  });
  FileUploaderState copyWith(
      {
        FileUploaderStatus? status,
        required String errorMessage}) {
    return FileUploaderState(
        uploadState: status ?? uploadState, errorMessage: errorMessage);
  }
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
