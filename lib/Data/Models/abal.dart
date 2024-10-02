import 'package:cloud_firestore/cloud_firestore.dart';

class AbalRegistrationModel {
  final FamilyInfo familyInfo;
  final String registrarId;
  final AbalModel abal;
  final String? comment;
  final bool isAdmin; // Added isAdmin field
  final String accountType; // Added accountType field

  AbalRegistrationModel({
    required this.familyInfo,
    required this.registrarId,
    required this.abal,
    this.comment,
    this.isAdmin = false, // Default value false
    this.accountType = '', // Default empty string
  });

  // Factory method to create AbalRegistrationModel from DocumentSnapshot
  factory AbalRegistrationModel.fromDoc(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return AbalRegistrationModel(
      familyInfo: FamilyInfo.fromJson(data['familyInfo'] ?? {}),
      registrarId: data['registrarId'] ?? '',
      abal: AbalModel.fromJson(data['abal'] ?? {}),
      comment: data['comment'],
      isAdmin: data['isAdmin'] ?? false,
      accountType: data['accountType'] ?? '',
    );
  }

  // Factory method to create AbalRegistrationModel from QueryDocumentSnapshot
  factory AbalRegistrationModel.fromDocument(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return AbalRegistrationModel(
      familyInfo: FamilyInfo.fromJson(data['familyInfo'] ?? {}),
      registrarId: data['registrarId'] ?? '',
      abal: AbalModel.fromJson(data['abal'] ?? {}),
      comment: data['comment'],
      isAdmin: data['isAdmin'] ?? false,
      accountType: data['accountType'] ?? '',
    );
  }

  // Factory method to create AbalRegistrationModel from JSON
  factory AbalRegistrationModel.fromJson(Map<String, dynamic> json) {
    return AbalRegistrationModel(
      familyInfo: FamilyInfo.fromJson(json['familyInfo'] ?? {}),
      registrarId: json['registrarId'] ?? '',
      abal: AbalModel.fromJson(json['abal'] ?? {}),
      comment: json['comment'],
      isAdmin: json['isAdmin'] ?? false,
      accountType: json['accountType'] ?? '',
    );
  }

  // Convert AbalRegistrationModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'familyInfo': familyInfo.toJson(),
      'registrarId': registrarId,
      'abal': abal.toJson(),
      'comment': comment,
      'isAdmin': isAdmin,
      'accountType': accountType,
    };
  }
}

class AbalModel {
  final String yekerestenaName;
  final String fullName;
  final String age;
  final String gender;
  final String phoneNumber;
  final String birthPlace;
  final String birthDate;
  final String subCity;
  final String woreda;
  final String kebele;
  final String houseNumber;
  final String emergencyContactFullName;
  final String emergencyContactPhoneNumber;
  final String kifile;
  String imagePath;

  AbalModel({
    required this.yekerestenaName,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.phoneNumber,
    required this.birthPlace,
    required this.birthDate,
    required this.subCity,
    required this.woreda,
    required this.kebele,
    required this.houseNumber,
    required this.emergencyContactFullName,
    required this.emergencyContactPhoneNumber,
    required this.kifile,
    required this.imagePath,
  });

  // Factory method to create AbalModel from JSON
  factory AbalModel.fromJson(Map<String, dynamic> json) {
    return AbalModel(
      yekerestenaName: json['yekerestenaName'] ?? '',
      fullName: json['fullName'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      birthPlace: json['birthPlace'] ?? '',
      birthDate: json['birthDate'] ?? '',
      subCity: json['subCity'] ?? '',
      woreda: json['woreda'] ?? '',
      kebele: json['kebele'] ?? '',
      houseNumber: json['houseNumber'] ?? '',
      emergencyContactFullName: json['emergencyContactFullName'] ?? '',
      emergencyContactPhoneNumber: json['emergencyContactPhoneNumber'] ?? '',
      kifile: json['kifile'] ?? '',
      imagePath: json['imagePath'] ?? '',
    );
  }

  // Convert AbalModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'yekerestenaName': yekerestenaName,
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'birthPlace': birthPlace,
      'birthDate': birthDate,
      'subCity': subCity,
      'woreda': woreda,
      'kebele': kebele,
      'houseNumber': houseNumber,
      'emergencyContactFullName': emergencyContactFullName,
      'emergencyContactPhoneNumber': emergencyContactPhoneNumber,
      'kifile': kifile,
      'imagePath': imagePath,
    };
  }
}

class FamilyInfo {
  final String familyYekerestenaName;
  final String familyFullName;
  final String relationShip;
  final String familyAge;
  final String familyGender;
  final String familyPhoneNumber;
  final String familyBirthPlace;
  final String familyBirthDate;
  final String familySubCity;
  final String familyWoreda;
  final String familyKebele;
  final String familyHouseNumber;
  String imagePath;

  FamilyInfo({
    required this.familyYekerestenaName,
    required this.familyFullName,
    required this.relationShip,
    required this.familyAge,
    required this.familyGender,
    required this.familyPhoneNumber,
    required this.familyBirthPlace,
    required this.familyBirthDate,
    required this.familySubCity,
    required this.familyWoreda,
    required this.familyKebele,
    required this.familyHouseNumber,
    required this.imagePath,
  });

  // Factory method to create FamilyInfo from JSON
  factory FamilyInfo.fromJson(Map<String, dynamic> json) {
    return FamilyInfo(
      familyYekerestenaName: json['familyYekerestenaName'] ?? '',
      familyFullName: json['familyFullName'] ?? '',
      relationShip: json['relationShip'] ?? '',
      familyAge: json['familyAge'] ?? '',
      familyGender: json['familyGender'] ?? '',
      familyPhoneNumber: json['familyPhoneNumber'] ?? '',
      familyBirthPlace: json['familyBirthPlace'] ?? '',
      familyBirthDate: json['familyBirthDate'] ?? '',
      familySubCity: json['familySubCity'] ?? '',
      familyWoreda: json['familyWoreda'] ?? '',
      familyKebele: json['familyKebele'] ?? '',
      familyHouseNumber: json['familyHouseNumber'] ?? '',
      imagePath: json['imagePath'] ?? '',
    );
  }

  // Convert FamilyInfo to JSON
  Map<String, dynamic> toJson() {
    return {
      'familyYekerestenaName': familyYekerestenaName,
      'familyFullName': familyFullName,
      'relationShip': relationShip,
      'familyAge': familyAge,
      'familyGender': familyGender,
      'familyPhoneNumber': familyPhoneNumber,
      'familyBirthPlace': familyBirthPlace,
      'familyBirthDate': familyBirthDate,
      'familySubCity': familySubCity,
      'familyWoreda': familyWoreda,
      'familyKebele': familyKebele,
      'familyHouseNumber': familyHouseNumber,
      'imagePath': imagePath,
    };
  }
}
