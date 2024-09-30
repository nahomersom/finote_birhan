import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:finote_birhan_mobile/Business%20Logic/Bloc/cubit/file_uploader_cubit.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/light_theme.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';

import '../../../../Business Logic/Algorithm/file-uploader.dart';
import '../../../../Business Logic/Bloc/cubit/abals/abal_cubit.dart';
import '../../../../Data/Models/abal.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  int currentStep = 0;
  //abal information
  final _yekerestenaNameControl = TextEditingController();
  final _fullNameControl = TextEditingController();
  final _ageControl = TextEditingController();
  final _genderControl = TextEditingController();
  final _phoneNumberControl = TextEditingController();
  final _birthPlaceControl = TextEditingController();
  final _birthDateControl = TextEditingController();
  final _subCityControl = TextEditingController();
  final _woredaControl = TextEditingController();
  final _kebeleControl = TextEditingController();
  final _houseNumberControl = TextEditingController();
  final _emergencyContactFullNameControl = TextEditingController();
  final _emergencyContactPhoneNumberControl = TextEditingController();
  final _kifileControl = TextEditingController();

  //abal family information
  final _familyYekerestenaNameControl = TextEditingController();
  final _familyFullNameControl = TextEditingController();
  final _relationShipControl = TextEditingController();
  final _familyAgeControl = TextEditingController();
  final _familyGenderControl = TextEditingController();
  final _familyPhoneNumberControl = TextEditingController();
  final _familyBirthPlaceControl = TextEditingController();
  final _familyBirthDateControl = TextEditingController();
  final _familySubCityControl = TextEditingController();
  final _familyWoredaControl = TextEditingController();
  final _familyKebeleControl = TextEditingController();
  final _familyHouseNumberControl = TextEditingController();

  final _abalFormKey = GlobalKey<FormState>();
  final _welageFormKey = GlobalKey<FormState>();

  //general
  final _commentControl = TextEditingController();

  String phoneNumber = "";
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
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;
    TextTheme textTheme = Theme.of(context).textTheme;

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
                steps: registrationSteps(sizeH, sizeW, state.nestedKifiles),
                onStepTapped: (step) => {},
                currentStep: currentStep,
                onStepContinue: () {
                  final lastStep = currentStep ==
                      registrationSteps(sizeH, sizeW, state.nestedKifiles)
                              .length -
                          1;
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
                      registrationSteps(sizeH, sizeW, state.nestedKifiles)
                              .length -
                          1;
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        Expanded(
                            child: Theme(
                          data: lightTheme,
                          child: TextButton(
                            onPressed: () => {
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
                    // FaIcon(
                    //   FontAwesomeIcons.solidCircleCheck,
                    //   size: 100,
                    //   color: ColorResources.accentColor,
                    // )
                    Lottie.asset('assets/animations/success.json', height: 350),
                    Text(
                      'ተሳክትዋል',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: ColorResources.secondaryColor,
                          fontSize: 30),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text('አባሉን ወደ ቅዋቱ መመዝገብ ተሳክትዋል.')),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                backgroundColor: ColorResources.secondaryColor),
                            onPressed: () => context.go('/dashboard'),
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

  List<Step> registrationSteps(height, width, List kifiles) => [
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
            content: Form(
              key: _abalFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        SizedBox(
                          height: 130,
                          width: 130,
                          child: CircleAvatar(
                              backgroundImage: hasAbalImage
                                  ? FileImage(
                                      abalImage!,
                                    )
                                  : Image.network('').image,
                              backgroundColor: Colors.white,
                              child: hasAbalImage
                                  ? SizedBox()
                                  : const Icon(
                                      Icons.person_outline_outlined,
                                      size: 60,
                                      color: ColorResources.secondaryColor,
                                    )),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 160,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20))),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text('ፎቶዎን ከየት ይወስዳሉ?',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall
                                                    ?.copyWith(
                                                        color: ColorResources
                                                            .textColor)),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await pickImage(
                                                  ImageSource.camera, true);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 20,
                                                  color:
                                                      ColorResources.textColor,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text('ካሜራ ያንሱ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                ColorResources
                                                                    .textColor))
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await pickImage(
                                                  ImageSource.gallery, true);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .photo_size_select_actual_outlined,
                                                  size: 20,
                                                  color:
                                                      ColorResources.textColor,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text('ከጋለሪ ይውሰዱ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                ColorResources
                                                                    .textColor))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            child: const SizedBox(
                              height: 50,
                              width: 50,
                              child: CircleAvatar(
                                backgroundColor: ColorResources.primaryColor,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    !hasAbalImage && isAbalFormSubmitted
                        ? Text('**ፎቶ ያስፈልጋል**',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: ColorResources.errorColor))
                        : const SizedBox(),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ይህ ቦታ መሞላት አለበት';
                          }
                          return null;
                        },
                        value: kifileValue,
                        isDense: true,
                        hint: const Text('ክፍል'),
                        isExpanded: true,
                        items: kifiles.map(
                          (e) {
                            return DropdownMenuItem<String>(
                                value: e['id'], child: Text(e['name']));
                          },
                        ).toList(),
                        onChanged: (newValue) {
                          _kifileControl.text = newValue ?? _kifileControl.text;
                          setState(() {
                            kifileValue = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _yekerestenaNameControl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('የክርስትና ስም')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _fullNameControl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text('ሙሉ ስም')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _ageControl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text('ዕድሜ')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ይህ ቦታ መሞላት አለበት';
                          }
                          return null;
                        },
                        value: sexValue,
                        isDense: true,
                        hint: const Text('ጾታ'),
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("ወንድ")),
                          DropdownMenuItem(value: "Female", child: Text("ሴት")),
                        ],
                        onChanged: (newValue) {
                          _genderControl.text = newValue ?? _genderControl.text;
                          setState(() {
                            sexValue = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    IntlPhoneField(
                      controller: _phoneNumberControl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'ስልክ ቁጥር',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'ET',
                      onChanged: (phone) {
                        phoneNumber = phone.completeNumber;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _birthPlaceControl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('የትውልድ ስፍራ')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _birthDateControl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('የትውልድ ዘመን')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ይህ ቦታ መሞላት አለበት';
                          }
                          return null;
                        },
                        value: kefleKetemaValue,
                        isDense: true,
                        hint: const Text('ክፈለ ከተማ'),
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "ledeta", child: Text("ልደታ")),
                          DropdownMenuItem(
                              value: "addis ketema", child: Text("አዲስ ከተማ")),
                          DropdownMenuItem(value: "arada", child: Text("አራዳ")),
                        ],
                        onChanged: (newValue) {
                          _subCityControl.text =
                              newValue ?? _subCityControl.text;
                          setState(() {
                            kefleKetemaValue = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _woredaControl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text('ወረዳ')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _kebeleControl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text('ቀበሌ')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _houseNumberControl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text('የቤት ቁጥር')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _emergencyContactFullNameControl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('የአደጋ ጊዜ ተጠሪ')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    IntlPhoneField(
                      controller: _emergencyContactPhoneNumberControl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'የአደጋ ጊዜ ተጠሪ ስልክ ቁጥር',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'ET',
                      onChanged: (phone) {
                        phoneNumber = phone.completeNumber;
                      },
                    ),
                  ],
                ),
              ),
            )),
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
            content: Form(
              key: _welageFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        SizedBox(
                          height: 130,
                          width: 130,
                          child: CircleAvatar(
                              backgroundImage: hasWelageImage
                                  ? FileImage(
                                      welageImage!,
                                    )
                                  : Image.network('').image,
                              backgroundColor: Colors.white,
                              child: hasWelageImage
                                  ? SizedBox()
                                  : const Icon(
                                      Icons.person_2_outlined,
                                      size: 60,
                                      color: ColorResources.secondaryColor,
                                    )),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 160,
                                    decoration: const BoxDecoration(
                                        color: ColorResources.primaryColor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20))),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text('ፎቶዎን ከየት ይወስዳሉ?',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall
                                                    ?.copyWith(
                                                        color: ColorResources
                                                            .textColor)),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await pickImage(
                                                  ImageSource.camera, false);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 25,
                                                  color:
                                                      ColorResources.textColor,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text('ካሜራ ያንሱ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                ColorResources
                                                                    .textColor))
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await pickImage(
                                                  ImageSource.gallery, false);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .photo_size_select_actual_outlined,
                                                  size: 25,
                                                  color:
                                                      ColorResources.textColor,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text('ከጋለሪ ይውሰዱ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                ColorResources
                                                                    .textColor))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            child: const SizedBox(
                              height: 50,
                              width: 50,
                              child: CircleAvatar(
                                backgroundColor: ColorResources.primaryColor,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    !hasWelageImage && isWelageFormSubmitted
                        ? const Text(
                            '**ፎቶ ያስፈልጋል**',
                            style: TextStyle(color: Colors.redAccent),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _familyYekerestenaNameControl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('የክርስትና ስም')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _familyFullNameControl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text('ሙሉ ስም')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ይህ ቦታ መሞላት አለበት';
                          }
                          return null;
                        },
                        isDense: true,
                        hint: const Text('ከአባሉ ጋር ያለው ግንኙነት'),
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "mother", child: Text("እናት")),
                          DropdownMenuItem(value: "father", child: Text("አባት")),
                          DropdownMenuItem(
                              value: "brother", child: Text("ወንድም")),
                          DropdownMenuItem(value: "sister", child: Text("አህት")),
                          DropdownMenuItem(
                              value: "Female", child: Text("ዘመድና")),
                        ],
                        onChanged: (newValue) {
                          _relationShipControl.text =
                              newValue ?? _relationShipControl.text;

                          setState(() {
                            relationshipValue = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _familyAgeControl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text('ዕድሜ')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ይህ ቦታ መሞላት አለበት';
                          }
                          return null;
                        },
                        value: sexValue,
                        isDense: true,
                        hint: const Text('ጾታ'),
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("ወንድ")),
                          DropdownMenuItem(value: "Female", child: Text("ሴት")),
                        ],
                        onChanged: (newValue) {
                          _familyGenderControl.text =
                              newValue ?? _familyGenderControl.text;
                          setState(() {
                            sexValue = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    IntlPhoneField(
                      controller: _familyPhoneNumberControl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'ስልክ ቁጥር',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'ET',
                      onChanged: (phone) {
                        phoneNumber = phone.completeNumber;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _familyBirthPlaceControl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('የትውልድ ስፍራ')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _familyBirthDateControl,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('የትውልድ ዘመን')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ይህ ቦታ መሞላት አለበት';
                          }
                          return null;
                        },
                        value: kefleKetemaValue,
                        isDense: true,
                        hint: const Text('ክፈለ ከተማ'),
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "ledeta", child: Text("ልደታ")),
                          DropdownMenuItem(
                              value: "addis ketema", child: Text("አዲስ ከተማ")),
                          DropdownMenuItem(value: "arada", child: Text("አራዳ")),
                        ],
                        onChanged: (newValue) {
                          _familySubCityControl.text =
                              newValue ?? _familySubCityControl.text;
                          setState(() {
                            kefleKetemaValue = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _familyWoredaControl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text('ወረዳ')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _familyKebeleControl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text('ቀበሌ')),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ይህ ቦታ መሞላት አለበት';
                        }
                        return null;
                      },
                      controller: _familyHouseNumberControl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text('የቤት ቁጥር')),
                    ),
                  ],
                ),
              ),
            )),
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
  Future pickImage(ImageSource source, bool isForAbal) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => {
            if (isForAbal)
              {
                abalImage = imageTemp,
                hasAbalImage = true,
              }
            else
              {welageImage = imageTemp, hasWelageImage = true}
          });

      if (!mounted) return;

      Navigator.pop(context);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

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
        emergencyContactPhoneNumber: _emergencyContactPhoneNumberControl.text,
        kifile: _kifileControl.text,
        imagePath: '');

    AbalRegistrationModel newAbal = AbalRegistrationModel(
        familyInfo: familyInfo, abal: abal, registrarId: '23232332');

    BlocProvider.of<AbalCubit>(context)
        .registerAbal(newAbal, welageImage, abalImage);

    print('===============called');
    print(newAbal);
  }
}

class Spinner extends StatelessWidget {
  final String text;
  Spinner({super.key, required this.text});

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
