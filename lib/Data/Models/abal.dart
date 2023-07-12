class AbalRegistrationModel {
  FamilyInfo familyInfo;
  RegistrarInfo registrarInfo;
  AbalModel abalModel;
  String? comment;

  AbalRegistrationModel({
    required this.familyInfo,
    required this.registrarInfo,
    required this.abalModel,
    this.comment,
  });
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

//abal family information

//general

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
  });
}

class RegistrarInfo {
  String fullName;
  String phoneNumber;
  RegistrarInfo({
    required this.fullName,
    required this.phoneNumber,
  });
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
}
