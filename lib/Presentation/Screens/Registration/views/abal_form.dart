import 'package:finote_birhan_mobile/Business%20Logic/Controllers/abal/abal_controller.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:finote_birhan_mobile/Data/Models/abal.dart';
import 'package:finote_birhan_mobile/Presentation/Components/dropdown_field.dart';
import 'package:finote_birhan_mobile/Presentation/Components/image_picker.dart';
import 'package:finote_birhan_mobile/Presentation/Components/phone_number_field.dart';
import 'package:finote_birhan_mobile/Presentation/Components/shared_button.dart';
import 'package:finote_birhan_mobile/Presentation/Components/shared_text_field.dart';
import 'package:finote_birhan_mobile/Presentation/Components/spinner.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/controllers/form_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AbalForm extends StatefulWidget {
  const AbalForm({super.key, required this.navigateToNextPage});
  final VoidCallback navigateToNextPage; // Passed from parent

  @override
  State<AbalForm> createState() => _AbalFormState();
}

class _AbalFormState extends State<AbalForm> {
  final _abalFormKey = GlobalKey<FormState>();
  final AbalController controller = Get.find<AbalController>();

  bool isAbalFormSubmitted = false;
  String phoneNumber = "";
  String emergencyPhoneNumber = "";
  String? sexValue;
  String? kifileValue;
  String? kefleKetemaValue;
  final formController = Get.put(FormController()); // Initialize the controller
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Obx(() {
        if (controller.hasError.value) {
          return Dialog(
            backgroundColor: ColorResources.secondaryColor,
            child: Text(
              controller.errorMessage.value,
            ),
          );
        }
        if (controller.nestedKifiles.isNotEmpty) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _abalFormKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: <Widget>[
                    const ImageSelector(
                      imageType: 'abalImage',
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    formController.getImage('abalImage') == null &&
                            isAbalFormSubmitted
                        ? Text('**ፎቶ ያስፈልጋል**',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: ColorResources.errorColor))
                        : const SizedBox(),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    sharedDropdownField(
                      value:
                          controller.selectedAbal?.abal.kifile ?? kifileValue,
                      hintText: 'ክፍል',
                      items: controller.nestedKifiles.map(
                        (e) {
                          return DropdownMenuItem<String>(
                              value: e['id'], child: Text(e['name']));
                        },
                      ).toList(),
                      onChanged: (newValue) {
                        formController.subKifileControl.text = newValue ?? '';
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.yekerestenaNameControl,
                      label: 'የክርስትና ስም',
                      initialValue:
                          controller.selectedAbal?.abal.yekerestenaName,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.fullNameControl,
                      label: 'ሙሉ ስም',
                      initialValue: controller.selectedAbal?.abal.fullName,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.ageControl,
                      label: 'ዕድሜ',
                      initialValue: controller.selectedAbal?.abal.age,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    sharedDropdownField(
                      value: controller.selectedAbal?.abal.gender ?? sexValue,
                      hintText: 'ጾታ',
                      items: const [
                        DropdownMenuItem(value: "Male", child: Text("ወንድ")),
                        DropdownMenuItem(value: "Female", child: Text("ሴት")),
                      ],
                      onChanged: (newValue) {
                        formController.genderControl.text = newValue ?? '';
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    PhoneNumberField(
                      label: 'ስልክ ቁጥር',
                      initialValue: controller.selectedAbal?.abal.phoneNumber,
                      controller: formController.phoneNumberControl,
                      onChanged: (phone) {
                        formController.phoneNumberControl.text = phone.number;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.birthPlaceControl,
                      label: 'የትውልድ ስፍራ',
                      initialValue: controller.selectedAbal?.abal.birthPlace,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.birthDateControl,
                      label: 'የትውልድ ዘመን',
                      initialValue: controller.selectedAbal?.abal.birthDate,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    sharedDropdownField(
                      value: controller.selectedAbal?.abal.subCity ??
                          kefleKetemaValue,
                      hintText: 'ክፍለ ከተማ',
                      items: const [
                        DropdownMenuItem(value: "ledeta", child: Text("ልደታ")),
                        DropdownMenuItem(
                            value: "addis ketema", child: Text("አዲስ ከተማ")),
                        DropdownMenuItem(value: "arada", child: Text("አራዳ")),
                      ],
                      onChanged: (newValue) {
                        formController.subCityControl.text = newValue ?? '';
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.woredaControl,
                      label: 'ወረዳ',
                      initialValue: controller.selectedAbal?.abal.woreda,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.kebeleControl,
                      label: 'ቀበሌ',
                      initialValue: controller.selectedAbal?.abal.kebele,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.houseNumberControl,
                      label: 'የቤት ቁጥር',
                      initialValue: controller.selectedAbal?.abal.houseNumber,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController:
                          formController.emergencyContactFullNameControl,
                      label: 'የአደጋ ጊዜ ተጠሪ',
                      initialValue: controller
                          .selectedAbal?.abal.emergencyContactFullName,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    PhoneNumberField(
                      label: 'የአደጋ ጊዜ ተጠሪ ስልክ ቁጥር',
                      initialValue: controller
                          .selectedAbal?.abal.emergencyContactPhoneNumber,
                      controller:
                          formController.emergencyContactPhoneNumberControl,
                      onChanged: (phone) {
                        formController.emergencyContactPhoneNumberControl.text =
                            phone.number;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SharedButton(
                        buttonText:
                            formController.kifile == 'ህጻናት' ? 'ወደ ቀጣይ' : 'ጨርስ',
                        isLoading: controller.isLoading.value,
                        onTap: () => {
                              setState(() {
                                isAbalFormSubmitted = true;
                              }),
                              if (_abalFormKey.currentState!.validate())
                                {
                                  if (formController.kifile == 'ህጻናት')
                                    {
                                      widget.navigateToNextPage(),
                                    }
                                  else
                                    {
                                      onSubmit(),
                                    }
                                }
                            })
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(child: Spinner());
      }),
    );
  }

  void onSubmit() {
    AbalModel abal = AbalModel(
        kifile: formController.kifile,
        yekerestenaName: formController.yekerestenaNameControl.text,
        fullName: formController.fullNameControl.text,
        age: formController.ageControl.text,
        gender: formController.genderControl.text,
        phoneNumber: formController.phoneNumberControl.text,
        birthPlace: formController.birthPlaceControl.text,
        birthDate: formController.birthDateControl.text,
        subCity: formController.subCityControl.text,
        woreda: formController.woredaControl.text,
        kebele: formController.kebeleControl.text,
        houseNumber: formController.houseNumberControl.text,
        emergencyContactFullName:
            formController.emergencyContactFullNameControl.text,
        emergencyContactPhoneNumber:
            formController.emergencyContactPhoneNumberControl.text,
        subKifile: formController.subKifileControl.text,
        imagePath: '',
        abalImage: formController.getImage('abalImage'));

    AbalRegistrationModel newAbal =
        AbalRegistrationModel(abal: abal, registrarId: '23232332');
    controller.registerAbal(newAbal);
  }
}
