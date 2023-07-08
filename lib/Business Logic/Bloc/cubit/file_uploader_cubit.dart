import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
part 'file_uploader_state.dart';

class FileUploaderCubit extends Cubit<FileUploaderState> {
  FileUploaderCubit() : super(const FileUploaderState(errorMessage: ''

  ));

  Future uploadFile(File? photo) async {
    print('==========================================================================================================================');
    print(photo);
    print('==========================================================================================================================');

    if (photo == null) return;
    final fileName = basename(photo.path);
    final destination = 'Sample/Images/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(photo);

      print('ref*******************************');
    } catch (e) {
      emit(state.copyWith(
          status: FileUploaderStatus.error, errorMessage: e.toString()));
      print('error occured');
    }
  }
}
