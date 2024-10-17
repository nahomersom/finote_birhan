import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FileUploader {
  Future<String?> uploadFile(String location, File? photo) async {
    if (photo == null) return null;

    try {
      // Get the file name with its extension
      final fileName = basename(photo.path);
      final destination = '$location/$fileName';
      print(
          '----------------------------File uploaded start $fileName $destination.');

      // Ensure no double slashes or special characters in the destination
      final storageReference = FirebaseStorage.instance.ref(destination);
      print(
          '----------------------------File uploaded start2 ${storageReference.fullPath}');
      // Upload the image
      UploadTask uploadTask = storageReference.putFile(photo);
      await uploadTask.whenComplete(() {});
      print('----------------------------File uploaded successfully.');

      // Return the download URL
      String downloadedUrl = await storageReference.getDownloadURL();
      print('dowonload url------------------------------------');
      print(downloadedUrl);
      return downloadedUrl;
    } catch (e) {
      print("----------------------Error during upload: $e");
      return null;
    }
  }
}
