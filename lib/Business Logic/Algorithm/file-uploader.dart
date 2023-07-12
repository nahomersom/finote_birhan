import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FileUploader {
  Future uploadFile(location, File? photo) async {
    if (photo == null) return;
    //get the file name with its extenstion
    final fileName = basename(photo.path);

    final destination = '$location/$fileName';
    //get the reference of the image by assigning our desired location
    final storageReference = FirebaseStorage.instance.ref().child('የአባላት ፎቶዎች/$destination/');
    // upload the mage
    UploadTask uploadTask = storageReference.putFile(photo);
    await uploadTask.whenComplete(() {});
    print('================================================================');
    //to return the path of the image
    String downloaded = await storageReference.getDownloadURL();
    print(downloaded);
    return await storageReference.getDownloadURL();
  }
}
