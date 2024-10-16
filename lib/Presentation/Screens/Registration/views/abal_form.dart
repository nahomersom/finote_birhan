import 'package:finote_birhan_mobile/Business%20Logic/Controllers/abal/abal_controller.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:finote_birhan_mobile/Presentation/Components/dropdown_field.dart';
import 'package:finote_birhan_mobile/Presentation/Components/image_picker.dart';
import 'package:finote_birhan_mobile/Presentation/Components/phone_number_field.dart';
import 'package:finote_birhan_mobile/Presentation/Components/shared_button.dart';
import 'package:finote_birhan_mobile/Presentation/Components/shared_text_field.dart';
import 'package:finote_birhan_mobile/Presentation/Components/spinner.dart';
import 'package:finote_birhan_mobile/Presentation/Routes/app_navigator.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/controllers/form_controllers.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AbalForm extends StatefulWidget {
  const AbalForm({
    super.key,
  });

  @override
  State<AbalForm> createState() => _AbalFormState();
}

class _AbalFormState extends State<AbalForm> {
  final _abalFormKey = GlobalKey<FormState>();
  final AbalController controller = Get.find<AbalController>();

  bool isAbalFormSubmitted = false;
  String phoneNumber = "";
  String emergencyPhoneNumber = "";
  String? sexValue = "Male";
  String? kifileValue;
  String? kefleKetemaValue = "ledeta";
  final formController = Get.put(FormController()); // Initialize the controller
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const TabIndicator(selectedIndex: 1, title: 'አባል መረጃ'),
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
                      value: kifileValue,
                      hintText: 'ክፍል',
                      items: controller.nestedKifiles.map(
                        (e) {
                          return DropdownMenuItem<String>(
                              value: e['id'], child: Text(e['name']));
                        },
                      ).toList(),
                      onChanged: (newValue) {
                        formController.kifileControl.text = newValue ?? '';
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.yekerestenaNameControl,
                      label: 'የክርስትና ስም',
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.fullNameControl,
                      label: 'ሙሉ ስም',
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.ageControl,
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
                        formController.genderControl.text = newValue ?? '';
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    PhoneNumberField(
                      label: 'ስልክ ቁጥር',
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
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.birthDateControl,
                      label: 'የትውልድ ዘመን',
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    sharedDropdownField(
                      value: kefleKetemaValue,
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
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.kebeleControl,
                      label: 'ቀበሌ',
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController: formController.houseNumberControl,
                      label: 'የቤት ቁጥር',
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedTextField(
                      formController:
                          formController.emergencyContactFullNameControl,
                      label: 'የአደጋ ጊዜ ተጠሪ',
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    PhoneNumberField(
                      label: 'የአደጋ ጊዜ ተጠሪ ስልክ ቁጥር',
                      controller:
                          formController.emergencyContactPhoneNumberControl,
                      onChanged: (phone) {
                        print(
                            'phone number is ------------------------------------');
                        print(phone);
                        formController.emergencyContactPhoneNumberControl.text =
                            phone.number;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SharedButton(
                        buttonText: 'ወደ ቀጣይ',
                        onTap: () => {
                              AppNavigator.startFamilyFormRegistration(),
                              setState(() {
                                isAbalFormSubmitted = true;
                              })
                            })
                  ],
                ),
              ),
            ),
          );
        }
        return const Spinner(text: 'ዝግጅት ላይ');
      }),
    );
  }
}
