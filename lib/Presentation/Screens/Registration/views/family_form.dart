import 'package:finote_birhan_mobile/Business%20Logic/Controllers/abal/abal_controller.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:finote_birhan_mobile/Presentation/Components/dropdown_field.dart';
import 'package:finote_birhan_mobile/Presentation/Components/image_picker.dart';
import 'package:finote_birhan_mobile/Presentation/Components/phone_number_field.dart';
import 'package:finote_birhan_mobile/Presentation/Components/shared_button.dart';
import 'package:finote_birhan_mobile/Presentation/Components/shared_text_field.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/controllers/form_controllers.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FamilyForm extends StatefulWidget {
  const FamilyForm({super.key});

  @override
  State<FamilyForm> createState() => _FamilyFormState();
}

class _FamilyFormState extends State<FamilyForm> {
  bool phoneNumberIsValid = true; // Track phone number validity
  final _familyFormKey = GlobalKey<FormState>();

  final AbalController controller = Get.find<AbalController>();

  bool isWelageFormSubmitted = false;
  String phoneNumber = "";
  String emergencyPhoneNumber = "";
  String? sexValue = "Male";
  String? relationShipValue = "mother";
  String? kifileValue;
  String? kefleKetemaValue = "ledeta";
  final formController = Get.put(FormController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const TabIndicator(selectedIndex: 2, title: 'የወላጅ መረጃ'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _familyFormKey,
            autovalidateMode: AutovalidateMode.always,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const ImageSelector(
                    imageType: 'welageImage',
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  formController.getImage('welageImage') != null &&
                          isWelageFormSubmitted
                      ? Text('**ፎቶ ያስፈልጋል**',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: ColorResources.errorColor))
                      : const SizedBox(),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SharedTextField(
                    formController: formController.yekerestenaNameControl,
                    label: 'የክርስትና ስም',
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SharedTextField(
                    formController: formController.familyFullNameControl,
                    label: 'ሙሉ ስም',
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  sharedDropdownField(
                      value: relationShipValue,
                      hintText: 'ከአባሉ ጋር ያለው ግንኙነት',
                      items: const [
                        DropdownMenuItem(value: "mother", child: Text("እናት")),
                        DropdownMenuItem(value: "father", child: Text("አባት")),
                        DropdownMenuItem(value: "brother", child: Text("ወንድም")),
                        DropdownMenuItem(value: "sister", child: Text("አህት")),
                        DropdownMenuItem(value: "Female", child: Text("ዘመድና")),
                      ],
                      onChanged: (newValue) {
                        formController.relationShipControl.text =
                            newValue ?? '';
                      }),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SharedTextField(
                    formController: formController.familyAgeControl,
                    label: 'ዕድሜ',
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  sharedDropdownField(
                    value: sexValue,
                    hintText: 'ጾታ',
                    items: const [
                      DropdownMenuItem(value: "Male", child: Text("ወንድ")),
                      DropdownMenuItem(value: "Female", child: Text("ሴት")),
                    ],
                    onChanged: (newValue) {
                      formController.familyGenderControl.text = newValue ?? '';
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  PhoneNumberField(
                    label: 'ስልክ ቁጥር',
                    controller: formController.familyPhoneNumberControl,
                    onChanged: (phone) {
                      formController.familyPhoneNumberControl.text =
                          phone.number;
                    },
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  if (formController.familyPhoneNumberControl.text.isEmpty &&
                      isWelageFormSubmitted)
                    Text('ይህ ቦታ ያስፈልጋል',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: ColorResources.errorColor)),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SharedTextField(
                    formController: formController.familyBirthPlaceControl,
                    label: 'የትውልድ ስፍራ',
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SharedTextField(
                    formController: formController.familyBirthDateControl,
                    label: 'የትውልድ ዘመን',
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  sharedDropdownField(
                    value: kefleKetemaValue,
                    hintText: 'ክፈለ ከተማ',
                    items: const [
                      DropdownMenuItem(value: "ledeta", child: Text("ልደታ")),
                      DropdownMenuItem(
                          value: "addis ketema", child: Text("አዲስ ከተማ")),
                      DropdownMenuItem(value: "arada", child: Text("አራዳ")),
                    ],
                    onChanged: (newValue) {
                      formController.familySubCityControl.text = newValue ?? '';
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SharedTextField(
                    formController: formController.familyWoredaControl,
                    label: 'ወረዳ',
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SharedTextField(
                    formController: formController.familyKebeleControl,
                    label: 'ቀበሌ',
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SharedTextField(
                    formController: formController.familyHouseNumberControl,
                    label: 'የቤት ቁጥር',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SharedButton(
                    buttonText: 'ጨርስ',
                    onTap: () => {
                      setState(
                        () {
                          isWelageFormSubmitted = true;
                        },
                      ),
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
