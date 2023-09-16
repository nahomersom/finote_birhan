class AbalRegistrationModel {
  FamilyInfo familyInfo;
  String registrarId;
  AbalModel abal;
  String? comment;

  AbalRegistrationModel({
    required this.familyInfo,
    required this.registrarId,
    required this.abal,
    this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'familyInfo': familyInfo.toJson(),
      'registrarId': registrarId,
      'abal': abal.toJson(),
      'comment': comment
    };
  }
}

class AbalModel {
  String yekerestenaName;
  String fullName;
  String age;
  String gender;
  String phoneNumber;
  String birthPlace;
  String birthDate;
  String subCity;
  String woreda;
  String kebele;
  String houseNumber;
  String emergencyContactFullName;
  String emergencyContactPhoneNumber;
  String kifile;
  String imagePath;

//abal family information

//general

  AbalModel({
    required this.imagePath,
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
  });
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
  String familyYekerestenaName;
  String familyFullName;
  String relationShip;
  String familyAge;
  String familyGender;
  String familyPhoneNumber;
  String familyBirthPlace;
  String familyBirthDate;
  String familySubCity;
  String familyWoreda;
  String familyKebele;
  String familyHouseNumber;
  String imagePath;
  FamilyInfo(
      {required this.familyYekerestenaName,
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
      required this.imagePath});
  Map<String, dynamic> toJson() {
    return {
      'familyYekerestenaName': familyYekerestenaName,
      'familyFullName': familyFullName,
      "relationShip": relationShip,
      'familyAge': familyAge,
      'familyGender': familyGender,
      'familyPhoneNumber': familyPhoneNumber,
      'familyBirthPlace': familyBirthPlace,
      'familyBirthDate': familyBirthDate,
      'familySubCity': familySubCity,
      'familyWoreda': familyWoreda,
      'familyKebele': familyKebele,
      'familyHouseNumber': familyHouseNumber,
      'imagePath': imagePath
    };
  }
}
