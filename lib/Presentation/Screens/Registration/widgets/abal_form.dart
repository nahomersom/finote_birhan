import 'dart:io';

import 'package:finote_birhan_mobile/Business%20Logic/Controllers/abal/abal_controller.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/controllers/form_controllers.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/views/registeration.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
        if (controller.kifiles.isNotEmpty) {
          return SingleChildScrollView(
            child: Form(
              key: _abalFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      SizedBox(
                        height: 130,
                        width: 130,
                        child: CircleAvatar(
                            backgroundImage: formController.abalImage != null
                                ? FileImage(
                                    formController.abalImage!,
                                  )
                                : Image.network('').image,
                            backgroundColor: Colors.white,
                            child: formController.abalImage != null
                                ? const SizedBox()
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
                                    padding: const EdgeInsets.all(20),
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
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await onImagePicked(
                                                ImageSource.camera, true);
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.camera_alt_outlined,
                                                size: 20,
                                                color: ColorResources.textColor,
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text('ካሜራ ያንሱ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorResources
                                                              .textColor))
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await onImagePicked(
                                                ImageSource.gallery, true);
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons
                                                    .photo_size_select_actual_outlined,
                                                size: 20,
                                                color: ColorResources.textColor,
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text('ከጋለሪ ይውሰዱ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorResources
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
                  formController.abalImage != null && isAbalFormSubmitted
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded border
                          borderSide: const BorderSide(
                              color: Colors.grey), // Border color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10), // Control height
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
                      items: controller.kifiles.map(
                        (e) {
                          return DropdownMenuItem<String>(
                              value: e['id'], child: Text(e['name']));
                        },
                      ).toList(),
                      onChanged: (newValue) {
                        formController.kifileControl.text = newValue ?? '';
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
                    controller: formController.yekerestenaNameControl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded border
                          borderSide: const BorderSide(
                              color: Colors.grey), // Border color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
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
                    controller: formController.fullNameControl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded border
                          borderSide: const BorderSide(
                              color: Colors.grey), // Border color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        label: Text('ሙሉ ስም')),
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
                    controller: formController.ageControl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded border
                          borderSide: const BorderSide(
                              color: Colors.grey), // Border color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        label: Text('ዕድሜ')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded border
                          borderSide: const BorderSide(
                              color: Colors.grey), // Border color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
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
                        formController.genderControl.text = newValue ?? '';
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  IntlPhoneField(
                    controller: formController.phoneNumberControl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'ስልክ ቁጥር',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'ET',
                    onChanged: (phone) {
                      formController.phoneNumberControl.text =
                          phone.completeNumber;
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
                    controller: formController.birthPlaceControl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded border
                          borderSide: const BorderSide(
                              color: Colors.grey), // Border color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
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
                    controller: formController.birthDateControl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded border
                          borderSide: const BorderSide(
                              color: Colors.grey), // Border color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        label: Text('የትውልድ ዘመን')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded border
                          borderSide: const BorderSide(
                              color: Colors.grey), // Border color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
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
                        formController.subCityControl.text = newValue ?? '';
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
                    controller: formController.woredaControl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded border
                          borderSide: const BorderSide(
                              color: Colors.grey), // Border color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        label: Text('ወረዳ')),
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
                    controller: formController.kebeleControl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded border
                          borderSide: const BorderSide(
                              color: Colors.grey), // Border color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        label: Text('ቀበሌ')),
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
                    controller: formController.houseNumberControl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded border
                          borderSide: const BorderSide(
                              color: Colors.grey), // Border color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        label: Text('የቤት ቁጥር')),
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
                    controller: formController.emergencyContactFullNameControl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded border
                          borderSide: const BorderSide(
                              color: Colors.grey), // Border color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        label: Text('የአደጋ ጊዜ ተጠሪ')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  IntlPhoneField(
                    controller:
                        formController.emergencyContactPhoneNumberControl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'የአደጋ ጊዜ ተጠሪ ስልክ ቁጥር',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'ET',
                    onChanged: (phone) {
                      formController.emergencyContactFullNameControl.text =
                          phone.completeNumber;
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return Spinner(text: 'ዝግጅት ላይ');
      }),
    );
  }

  Future<void> onImagePicked(ImageSource source, bool isForAbal) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile == null) return;

      setState(() {
        final pickedImage = File(pickedFile.path);

        formController.abalImage = pickedImage;
      });

      if (!mounted) return;

      Navigator.pop(context); // Close the image picker after picking
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
