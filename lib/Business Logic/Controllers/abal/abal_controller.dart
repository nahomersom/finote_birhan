import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finote_birhan_mobile/Business%20Logic/Algorithm/file-uploader.dart';
import 'package:finote_birhan_mobile/Data/Models/abal.dart';
import 'package:finote_birhan_mobile/Data/Repositories/abal.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/UI/registeration.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class AbalController extends GetxController {
  final AbalRepository abalRepository;

  // Observable state using GetX
  RxBool isLoading = false.obs; // Track loading state
  RxBool hasError = false.obs; // Track error state
  RxBool isRegistered = false.obs; // Track registration state
  RxString errorMessage = ''.obs; // Store error messages

  // Data state
  var kifiles = <dynamic>[].obs;
  var nestedKifiles = <dynamic>[].obs;
  var abals = <AbalRegistrationModel>[].obs;
  var selectedAbal = Rxn<AbalRegistrationModel>(); // Allows null values

  AbalController({required this.abalRepository});

  // Fetch kifiles
  Future<List> getKifiles() async {
    isLoading.value = true;
    hasError.value = false;
    kifiles.clear();

    try {
      QuerySnapshot querySnapshot = await abalRepository.getKifiles();
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.reference.id;
        kifiles.add(data);
      }
      kifiles.sort((a, b) => a['step'].compareTo(b['step']));
      isLoading.value = false;
      return kifiles;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = e.toString();
      throw Exception(e.toString());
    }
  }

  // Fetch nested kifiles
  Future<List> getNestedKifiles(
      String documentId, String childCollectionName) async {
    isLoading.value = true;
    hasError.value = false;
    nestedKifiles.clear();

    try {
      QuerySnapshot querySnapshot = await abalRepository.getNestedKifiles(
          documentId, childCollectionName);
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.reference.id;
        nestedKifiles.add(data);
      }
      nestedKifiles.sort((a, b) => a['step'].compareTo(b['step']));
      isLoading.value = false;
      return nestedKifiles;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = e.toString();
      throw Exception(e.toString());
    }
  }

  // Register a new Abal
  Future<void> registerAbal(
      AbalRegistrationModel abal, File? welageImage, File? abalImage) async {
    final FileUploader fileUploader = FileUploader();
    isLoading.value = true;
    hasError.value = false;

    try {
      // Upload images
      String abalImagePath =
          await fileUploader.uploadFile('ህጻናት/አባል', abalImage);
      String welageImagePath =
          await fileUploader.uploadFile('ህጻናት/ወላጅ', welageImage);

      abal.abal.imagePath = abalImagePath;
      abal.familyInfo.imagePath = welageImagePath;

      // Save to Firestore
      CollectionReference abalsCollection =
          FirebaseFirestore.instance.collection('abals');
      await abalsCollection.add(abal.toJson());

      isRegistered.value = true;
      isLoading.value = false;
    } catch (err) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = err.toString();
    }
  }

  Future<List<AbalRegistrationModel>> getAbals() async {
    isLoading.value = true;
    hasError.value = false;
    logger.w('called here - starting to fetch data');

    try {
      QuerySnapshot querySnapshot = await abalRepository.getAbals();
      abals.value = querySnapshot.docs
          .map((doc) => AbalRegistrationModel.fromDoc(doc))
          .toList();

      if (abals.isEmpty) {
        logger.w('No abals found');
      } else {
        logger.w('Abals fetched successfully');
        logger.w(abals.value.elementAt(0).abal.fullName);
      }

      isLoading.value = false;
      return abals;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = e.toString();
      logger.w('Error fetching abals: $e');
    }

    return [];
  }

  // Set the selected Abal for editing
  void setSelectedAbal(AbalRegistrationModel abal) {
    selectedAbal.value = abal;
  }
}
