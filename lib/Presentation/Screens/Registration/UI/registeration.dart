import 'dart:io';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/widgets/abal_form.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/widgets/family_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/light_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import '../../../../Business Logic/Bloc/cubit/abals/abal_cubit.dart';
import '../../../../Data/Models/abal.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  int currentStep = 0;
  // Controllers for the Abal form
  late TextEditingController _yekerestenaNameControl;
  late TextEditingController _fullNameControl;
  late TextEditingController _ageControl;
  late TextEditingController _genderControl;
  late TextEditingController _phoneNumberControl;
  late TextEditingController _birthPlaceControl;
  late TextEditingController _birthDateControl;
  late TextEditingController _subCityControl;
  late TextEditingController _woredaControl;
  late TextEditingController _kebeleControl;
  late TextEditingController _houseNumberControl;
  late TextEditingController _emergencyContactFullNameControl;
  late TextEditingController _emergencyContactPhoneNumberControl;
  late TextEditingController _kifileControl;

  // Controllers for the Family form
  late TextEditingController _familyYekerestenaNameControl;
  late TextEditingController _familyFullNameControl;
  late TextEditingController _relationShipControl;
  late TextEditingController _familyAgeControl;
  late TextEditingController _familyGenderControl;
  late TextEditingController _familyPhoneNumberControl;
  late TextEditingController _familyBirthPlaceControl;
  late TextEditingController _familyBirthDateControl;
  late TextEditingController _familySubCityControl;
  late TextEditingController _familyWoredaControl;
  late TextEditingController _familyKebeleControl;
  late TextEditingController _familyHouseNumberControl;

  final _abalFormKey = GlobalKey<FormState>();
  final _welageFormKey = GlobalKey<FormState>();

  //general
  final _commentControl = TextEditingController();

  String phoneNumber = "";
  String emergencyPhoneNumber = "";
  String? sexValue = "Male";
  String? kifileValue;
  String? kefleKetemaValue = "ledeta";
  String? relationshipValue = "";

  File? abalImage;
  File? welageImage;
  bool hasAbalImage = false;
  bool hasWelageImage = false;
  bool isCompleted = false;

  bool isWelageFormSubmitted = false;
  bool isAbalFormSubmitted = false;

  String? dropdownValidator(String? value) {
    return 'ይህ ቦታ መሞላት አለበትn';
  }

  @override
  void initState() {
    super.initState();

    // Initialize controllers here
    initializeControllers();
  }

  void initializeControllers() {
    final AbalCubit abalCubit = context.read<AbalCubit>();
    final AbalRegistrationModel? selectedAbal = abalCubit.state.selectedAbal;

    // Initialize Abal information controllers with selectedAbal data if it exists
    _yekerestenaNameControl =
        TextEditingController(text: selectedAbal?.abal.yekerestenaName ?? '');
    _fullNameControl =
        TextEditingController(text: selectedAbal?.abal.fullName ?? '');
    _ageControl = TextEditingController(text: selectedAbal?.abal.age ?? '');
    _genderControl =
        TextEditingController(text: selectedAbal?.abal.gender ?? '');
    _phoneNumberControl =
        TextEditingController(text: selectedAbal?.abal.phoneNumber ?? '');
    _birthPlaceControl =
        TextEditingController(text: selectedAbal?.abal.birthPlace ?? '');
    _birthDateControl =
        TextEditingController(text: selectedAbal?.abal.birthDate ?? '');
    _subCityControl =
        TextEditingController(text: selectedAbal?.abal.subCity ?? '');
    _woredaControl =
        TextEditingController(text: selectedAbal?.abal.woreda ?? '');
    _kebeleControl =
        TextEditingController(text: selectedAbal?.abal.kebele ?? '');
    _houseNumberControl =
        TextEditingController(text: selectedAbal?.abal.houseNumber ?? '');
    _emergencyContactFullNameControl = TextEditingController(
        text: selectedAbal?.abal.emergencyContactFullName ?? '');
    _emergencyContactPhoneNumberControl = TextEditingController(
        text: selectedAbal?.abal.emergencyContactPhoneNumber ?? '');
    _kifileControl =
        TextEditingController(text: selectedAbal?.abal.kifile ?? '');

    // Initialize Family information controllers with selectedAbal data if it exists
    _familyYekerestenaNameControl = TextEditingController(
        text: selectedAbal?.familyInfo.familyYekerestenaName ?? '');
    _familyFullNameControl = TextEditingController(
        text: selectedAbal?.familyInfo.familyFullName ?? '');
    _relationShipControl = TextEditingController(
        text: selectedAbal?.familyInfo.relationShip ?? '');
    _familyAgeControl =
        TextEditingController(text: selectedAbal?.familyInfo.familyAge ?? '');
    _familyGenderControl = TextEditingController(
        text: selectedAbal?.familyInfo.familyGender ?? '');
    _familyPhoneNumberControl = TextEditingController(
        text: selectedAbal?.familyInfo.familyPhoneNumber ?? '');
    _familyBirthPlaceControl = TextEditingController(
        text: selectedAbal?.familyInfo.familyBirthPlace ?? '');
    _familyBirthDateControl = TextEditingController(
        text: selectedAbal?.familyInfo.familyBirthDate ?? '');
    _familySubCityControl = TextEditingController(
        text: selectedAbal?.familyInfo.familySubCity ?? '');
    _familyWoredaControl = TextEditingController(
        text: selectedAbal?.familyInfo.familyWoreda ?? '');
    _familyKebeleControl = TextEditingController(
        text: selectedAbal?.familyInfo.familyKebele ?? '');
    _familyHouseNumberControl = TextEditingController(
        text: selectedAbal?.familyInfo.familyHouseNumber ?? '');

    // If there is a selectedAbal, initialize the dropdown value
    kifileValue = selectedAbal?.abal.kifile;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final AbalCubit abalCubit = context.read<AbalCubit>();

    // Access the selected Abal from the state
    final AbalRegistrationModel? selectedAbal = abalCubit.state.selectedAbal;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'የአባል መመዝገቢያ',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(),
        ),
      ),
      body: SafeArea(
        child: Theme(
          data: ThemeData(canvasColor: Colors.white),
          child: BlocConsumer<AbalCubit, AbalState>(listener: (context, state) {
            if (state.abalStatus.hasError) {
              Dialog(
                backgroundColor: ColorResources.secondaryColor,
                child: Text(
                  state.errorMessage,
                ),
              );
            }
          }, builder: (BuildContext context, state) {
            if (state.abalStatus.isSuccess) {
              return Stepper(
                elevation: 0,
                type: StepperType.horizontal,
                steps: registrationSteps(state.nestedKifiles),
                onStepTapped: (step) => {},
                currentStep: currentStep,
                onStepContinue: () {
                  final lastStep = currentStep ==
                      registrationSteps(state.nestedKifiles).length - 1;
                  if (lastStep) {
                    //TODO:send data to the server
                    setState(() {
                      isCompleted = true;
                    });
                    return;
                  }
                  setState(() => currentStep += 1);
                },
                onStepCancel: () => {
                  currentStep == 0 ? null : setState(() => currentStep -= 1),
                },
                controlsBuilder: (context, ControlsDetails details) {
                  final bool isLastStep = details.currentStep ==
                      registrationSteps(state.nestedKifiles).length - 1;
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        Expanded(
                            child: Theme(
                          data: lightTheme,
                          child: TextButton(
                            onPressed: () => {
                              logger.w("is there $hasAbalImage"),
                              logger.w(_abalFormKey.currentState!.validate()),
                              //check if the the form is valid
                              _abalFormKey.currentState == null
                                  ? null
                                  : (currentStep == 0 &&
                                              _abalFormKey.currentState!
                                                  .validate() &&
                                              hasAbalImage) ||
                                          (currentStep == 1 &&
                                              _welageFormKey.currentState!
                                                  .validate() &&
                                              hasWelageImage)
                                      ? details.onStepContinue!()
                                      : isLastStep
                                          ? submit()
                                          : null,
                              setState(() {
                                currentStep == 0
                                    ? isAbalFormSubmitted = true
                                    : currentStep == 1
                                        ? isWelageFormSubmitted = true
                                        : null;
                              })
                            },
                            child: Text(
                              isLastStep ? 'አጠናቅ' : 'ቀጣይ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 12,
                        ),
                        if (currentStep != 0)
                          Expanded(
                              child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                backgroundColor: ColorResources.secondaryColor
                                    .withOpacity(0.1)),
                            onPressed: details.onStepCancel,
                            child: const Text('መመለስ'),
                          )),
                      ],
                    ),
                  );
                },
              );
            }

            if (state.abalStatus.isRegistering) {
              return Spinner(text: 'አባሉን በመመዝገብ ላይ');
            }
            if (state.abalStatus.isRegistered) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/success.json', height: 350),
                    const Text(
                      'ተሳክትዋል',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: ColorResources.secondaryColor,
                          fontSize: 30),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text('አባሉን ወደ ቅዋቱ መመዝገብ ተሳክትዋል.')),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                backgroundColor: ColorResources.secondaryColor),
                            onPressed: () => Get.toNamed('/dashboard'),
                            child: Text(
                              'መመለስ',
                              style: textTheme.titleSmall?.copyWith(
                                  color: ColorResources.primaryColor),
                            ),
                          )),
                    ),
                  ],
                ),
              );
            }

            return Spinner(text: 'ዝግጅት ላይ');
          }),
        ),
      ),
    );
  }

  List<Step> registrationSteps(List kifiles) => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('የአባል መረጃ',
              style: currentStep >= 0
                  ? Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: ColorResources.secondaryColor)
                  : Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: ColorResources.textColor.withOpacity(0.6))),
          content: AbalForm(
            formKey: _abalFormKey,
            kifiles: kifiles,
            yekerestenaNameControl: _yekerestenaNameControl,
            fullNameControl: _fullNameControl,
            ageControl: _ageControl,
            genderControl: _genderControl,
            phoneNumberControl: _phoneNumberControl,
            birthPlaceControl: _birthPlaceControl,
            birthDateControl: _birthDateControl,
            subCityControl: _subCityControl,
            woredaControl: _woredaControl,
            kebeleControl: _kebeleControl,
            houseNumberControl: _houseNumberControl,
            emergencyContactFullNameControl: _emergencyContactFullNameControl,
            emergencyContactPhoneNumberControl:
                _emergencyContactPhoneNumberControl,
            kifileControl: _kifileControl,
            kifileValue: kifileValue,
            kefleKetemaValue: kefleKetemaValue,
            sexValue: sexValue,
            isAbalFormSubmitted: isAbalFormSubmitted,
            onKifileChanged: (value) => {kifileValue = value},
            onSexChanged: (value) => {sexValue = value},
            onKefeleKetemaChanged: (value) => {kefleKetemaValue = value},
            onPhoneNumberChanged: (value) => {phoneNumber = value},
            onEmergencyPhoneNumberChanged: (value) =>
                {emergencyPhoneNumber = value},
            hasAbalImage: hasAbalImage, // Passing hasAbalImage
            abalImage: abalImage, // Passing abalImage
            onImagePicked: (imageSource, isForAbal) =>
                pickImage(imageSource, isForAbal),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('የወላጅ መረጃ',
              style: currentStep >= 1
                  ? Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: ColorResources.secondaryColor)
                  : Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: ColorResources.textColor.withOpacity(0.6))),
          content: FamilyForm(
            formKey: _welageFormKey,
            familyYekerestenaNameControl: _familyYekerestenaNameControl,
            familyFullNameControl: _familyFullNameControl,
            relationShipControl: _relationShipControl,
            familyAgeControl: _familyAgeControl,
            familyGenderControl: _familyGenderControl,
            familyPhoneNumberControl: _familyPhoneNumberControl,
            familyBirthPlaceControl: _familyBirthPlaceControl,
            familyBirthDateControl: _familyBirthDateControl,
            familySubCityControl: _familySubCityControl,
            familyWoredaControl: _familyWoredaControl,
            familyKebeleControl: _familyKebeleControl,
            familyHouseNumberControl: _familyHouseNumberControl,
            isWelageFormSubmitted: isWelageFormSubmitted,
            onRelationShipChanged: (value) => {relationshipValue = value},
            onFamilySexChanged: (value) => {sexValue = value},
            onFamilySubCityChanged: (value) => {kefleKetemaValue = value},
            onFamilyPhoneNumberChanged: (value) =>
                {_familyPhoneNumberControl.text = value},
            hasWelageImage: hasWelageImage,
            welageImage: welageImage,
            onImagePicked: (imageSource, isForAbal) =>
                pickImage(imageSource, isForAbal),
          ),
        ),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 2,
            title: Text('ማጠቃለያ',
                style: currentStep >= 2
                    ? Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: ColorResources.secondaryColor)
                    : Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorResources.textColor.withOpacity(0.6))),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ይህ ቦታ መሞላት አለበት';
                      }
                      return null;
                    },
                    controller: _commentControl,
                    decoration: const InputDecoration(label: Text('አስተያየት')),
                  )
                ],
              ),
            ))
      ];

  Future submit() async {
    FamilyInfo familyInfo = FamilyInfo(
        familyYekerestenaName: _familyYekerestenaNameControl.text,
        familyFullName: _familyFullNameControl.text,
        relationShip: _relationShipControl.text,
        familyAge: _familyAgeControl.text,
        familyGender: _familyGenderControl.text,
        familyPhoneNumber: _familyPhoneNumberControl.text,
        familyBirthPlace: _familyBirthPlaceControl.text,
        familyBirthDate: _familyBirthDateControl.text,
        familySubCity: _familySubCityControl.text,
        familyWoreda: _familyWoredaControl.text,
        familyKebele: _familyKebeleControl.text,
        familyHouseNumber: _familyHouseNumberControl.text,
        imagePath: '');
    AbalModel abal = AbalModel(
        yekerestenaName: _yekerestenaNameControl.text,
        fullName: _fullNameControl.text,
        age: _ageControl.text,
        gender: _genderControl.text,
        phoneNumber: phoneNumber,
        birthPlace: _birthPlaceControl.text,
        birthDate: _birthDateControl.text,
        subCity: _subCityControl.text,
        woreda: _woredaControl.text,
        kebele: _kebeleControl.text,
        houseNumber: _houseNumberControl.text,
        emergencyContactFullName: _emergencyContactFullNameControl.text,
        emergencyContactPhoneNumber: emergencyPhoneNumber,
        kifile: _kifileControl.text,
        imagePath: '');

    AbalRegistrationModel newAbal = AbalRegistrationModel(
        familyInfo: familyInfo, abal: abal, registrarId: '23232332');

    BlocProvider.of<AbalCubit>(context)
        .registerAbal(newAbal, welageImage, abalImage);

    print('===============called');
    print(newAbal);
  }

  @override
  void dispose() {
    // Dispose of all controllers
    _yekerestenaNameControl.dispose();
    _fullNameControl.dispose();
    _ageControl.dispose();
    _genderControl.dispose();
    _phoneNumberControl.dispose();
    _birthPlaceControl.dispose();
    _birthDateControl.dispose();
    _subCityControl.dispose();
    _woredaControl.dispose();
    _kebeleControl.dispose();
    _houseNumberControl.dispose();
    _emergencyContactFullNameControl.dispose();
    _emergencyContactPhoneNumberControl.dispose();
    _kifileControl.dispose();

    // Family information controllers
    _familyYekerestenaNameControl.dispose();
    _familyFullNameControl.dispose();
    _relationShipControl.dispose();
    _familyAgeControl.dispose();
    _familyGenderControl.dispose();
    _familyPhoneNumberControl.dispose();
    _familyBirthPlaceControl.dispose();
    _familyBirthDateControl.dispose();
    _familySubCityControl.dispose();
    _familyWoredaControl.dispose();
    _familyKebeleControl.dispose();
    _familyHouseNumberControl.dispose();

    super.dispose();
  }

  Future<void> pickImage(ImageSource source, bool isForAbal) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile == null) return;

      setState(() {
        final pickedImage = File(pickedFile.path);

        if (isForAbal) {
          abalImage = pickedImage;
          hasAbalImage = true;
        } else {
          welageImage = pickedImage;
          hasWelageImage = true;
        }
      });

      if (!mounted) return;

      Navigator.pop(context); // Close the image picker after picking
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }
}

class Spinner extends StatelessWidget {
  final String text;
  const Spinner({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SpinKitFadingCircle(
        color: ColorResources.secondaryColor,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(text)
    ]);
  }
}
