import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  // abal form controllers
  final yekerestenaNameControl = TextEditingController();
  final fullNameControl = TextEditingController();
  final ageControl = TextEditingController();
  final genderControl = TextEditingController();
  final phoneNumberControl = TextEditingController();
  final birthPlaceControl = TextEditingController();
  final birthDateControl = TextEditingController();
  final subCityControl = TextEditingController();
  final woredaControl = TextEditingController();
  final kebeleControl = TextEditingController();
  final houseNumberControl = TextEditingController();
  final emergencyContactFullNameControl = TextEditingController();
  final emergencyContactPhoneNumberControl = TextEditingController();
  String kifile = '';
  final subKifileControl = TextEditingController();

  // welage form controllers
  final familyYekerestenaNameControl = TextEditingController();
  final familyFullNameControl = TextEditingController();
  final relationShipControl = TextEditingController();
  final familyAgeControl = TextEditingController();
  final familyGenderControl = TextEditingController();
  final familyPhoneNumberControl = TextEditingController();
  final familyBirthPlaceControl = TextEditingController();
  final familyBirthDateControl = TextEditingController();
  final familySubCityControl = TextEditingController();
  final familyWoredaControl = TextEditingController();
  final familyKebeleControl = TextEditingController();
  final familyHouseNumberControl = TextEditingController();
// Use a map to store images dynamically based on image type
  final Map<String, File?> imageMap = <String, File?>{}.obs;

  // Function to update the image in the map
  void setImage(String imageType, File? image) {
    imageMap[imageType] = image;
    update(); // Update the UI when image changes
  }

  // Function to get the image from the map
  File? getImage(String imageType) {
    return imageMap[imageType];
  }

  // Method to collect all form data across pages
  Map<String, dynamic> getAllFormData() {
    return {
      //abal
      'yekerestenaNameControl': yekerestenaNameControl.text,
      'fullNameControl': fullNameControl.text,
      'ageControl': ageControl.text,
      'genderControl': genderControl.text,
      'phoneNumberControl': phoneNumberControl.text,
      'birthPlaceControl': birthPlaceControl.text,
      'birthDateControl': birthDateControl.text,
      'subCityControl': subCityControl.text,
      'woredaControl': woredaControl.text,
      'kebeleControl': kebeleControl.text,
      'houseNumberControl': houseNumberControl.text,
      'emergencyContactFullNameControl': emergencyContactFullNameControl.text,
      'emergencyContactPhoneNumberControl':
          emergencyContactPhoneNumberControl.text,
      'kifile': kifile,
      'subKifileControl': subKifileControl.text,

      // family data
      'familyYekerestenaNameControl': familyYekerestenaNameControl.text,
      'familyFullNameControl': familyFullNameControl.text,
      'relationShipControl': relationShipControl.text,
      'familyAgeControl': familyAgeControl.text,
      'familyGenderControl': familyGenderControl.text,
      'familyPhoneNumberControl': familyPhoneNumberControl.text,
      'familyBirthPlaceControl': familyBirthPlaceControl.text,
      'familyBirthDateControl': familyBirthDateControl.text,
      'familySubCityControl': familySubCityControl.text,
      'familyWoredaControl': familyWoredaControl.text,
      'familyKebeleControl': familyKebeleControl.text,
      'familyHouseNumberControl': familyHouseNumberControl.text,
      // Continue for Page 3
    };
  }

  // Optional: Method to reset all form data
  void resetForm() {
    // abal form controllers
    yekerestenaNameControl.clear();
    fullNameControl.clear();
    ageControl.clear();
    genderControl.clear();
    phoneNumberControl.clear();
    birthPlaceControl.clear();
    birthDateControl.clear();
    subCityControl.clear();
    woredaControl.clear();
    kebeleControl.clear();
    houseNumberControl.clear();
    emergencyContactFullNameControl.clear();
    emergencyContactPhoneNumberControl.clear();
    kifile = '';
    subKifileControl.clear();

    // welage form controllers
    familyYekerestenaNameControl.clear();
    familyFullNameControl.clear();
    relationShipControl.clear();
    familyAgeControl.clear();
    familyGenderControl.clear();
    familyPhoneNumberControl.clear();
    familyBirthPlaceControl.clear();
    familyBirthDateControl.clear();
    familySubCityControl.clear();
    familyWoredaControl.clear();
    familyKebeleControl.clear();
    familyHouseNumberControl.clear();
  }

  @override
  void onClose() {
    // Dispose controllers when not needed anymore
    // abal form controllers
    yekerestenaNameControl.dispose();
    fullNameControl.dispose();
    ageControl.dispose();
    genderControl.dispose();
    phoneNumberControl.dispose();
    birthPlaceControl.dispose();
    birthDateControl.dispose();
    subCityControl.dispose();
    woredaControl.dispose();
    kebeleControl.dispose();
    houseNumberControl.dispose();
    emergencyContactFullNameControl.dispose();
    emergencyContactPhoneNumberControl.dispose();
    kifile = '';
    subKifileControl.dispose();

    // welage form controllers
    familyYekerestenaNameControl.dispose();
    familyFullNameControl.dispose();
    relationShipControl.dispose();
    familyAgeControl.dispose();
    familyGenderControl.dispose();
    familyPhoneNumberControl.dispose();
    familyBirthPlaceControl.dispose();
    familyBirthDateControl.dispose();
    familySubCityControl.dispose();
    familyWoredaControl.dispose();
    familyKebeleControl.dispose();
    familyHouseNumberControl.dispose();
    // Continue for other fields...
    super.onClose();
  }
}
