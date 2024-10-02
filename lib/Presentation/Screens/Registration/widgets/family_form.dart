import 'dart:io';

import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class FamilyForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController familyYekerestenaNameControl;
  final TextEditingController familyFullNameControl;
  final TextEditingController relationShipControl;
  final TextEditingController familyAgeControl;
  final TextEditingController familyGenderControl;
  final TextEditingController familyPhoneNumberControl;
  final TextEditingController familyBirthPlaceControl;
  final TextEditingController familyBirthDateControl;
  final TextEditingController familySubCityControl;
  final TextEditingController familyWoredaControl;
  final TextEditingController familyKebeleControl;
  final TextEditingController familyHouseNumberControl;
  final bool isWelageFormSubmitted;
  String? relationshipValue;
  String? kefleKetemaValue;
  String? sexValue;
  final Function(String?) onRelationShipChanged;
  final Function(String?) onFamilySexChanged;
  final Function(String?) onFamilySubCityChanged;
  final Function(String) onFamilyPhoneNumberChanged;

  FamilyForm(
      {super.key,
      required this.formKey,
      required this.familyYekerestenaNameControl,
      required this.familyFullNameControl,
      required this.relationShipControl,
      required this.familyAgeControl,
      required this.familyGenderControl,
      required this.familyPhoneNumberControl,
      required this.familyBirthPlaceControl,
      required this.familyBirthDateControl,
      required this.familySubCityControl,
      required this.familyWoredaControl,
      required this.familyKebeleControl,
      required this.familyHouseNumberControl,
      required this.isWelageFormSubmitted,
      this.relationshipValue,
      this.kefleKetemaValue,
      this.sexValue,
      required this.onRelationShipChanged,
      required this.onFamilySexChanged,
      required this.onFamilySubCityChanged,
      required this.onFamilyPhoneNumberChanged});

  @override
  State<FamilyForm> createState() => _FamilyFormState();
}

class _FamilyFormState extends State<FamilyForm> {
  File? welageImage;
  bool hasWelageImage = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Form(
      key: widget.formKey,
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
                          ? const SizedBox()
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
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text('ፎቶዎን ከየት ይወስዳሉ?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                                color:
                                                    ColorResources.textColor)),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await pickImage(ImageSource.camera);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.camera_alt_outlined,
                                          size: 25,
                                          color: ColorResources.textColor,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text('ካሜራ ያንሱ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
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
                                      await pickImage(ImageSource.gallery);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons
                                              .photo_size_select_actual_outlined,
                                          size: 25,
                                          color: ColorResources.textColor,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text('ከጋለሪ ይውሰዱ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
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
            !hasWelageImage && widget.isWelageFormSubmitted
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
              controller: widget.familyYekerestenaNameControl,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('የክርስትና ስም')),
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
              controller: widget.familyFullNameControl,
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
                  DropdownMenuItem(value: "brother", child: Text("ወንድም")),
                  DropdownMenuItem(value: "sister", child: Text("አህት")),
                  DropdownMenuItem(value: "Female", child: Text("ዘመድና")),
                ],
                onChanged: (newValue) {
                  widget.relationShipControl.text = newValue ?? '';
                  widget.onRelationShipChanged(newValue);
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
              controller: widget.familyAgeControl,
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
                value: widget.sexValue,
                isDense: true,
                hint: const Text('ጾታ'),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: "Male", child: Text("ወንድ")),
                  DropdownMenuItem(value: "Female", child: Text("ሴት")),
                ],
                onChanged: (newValue) {
                  widget.familyGenderControl.text = newValue ?? '';
                  widget.onFamilySexChanged(newValue);
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            IntlPhoneField(
              controller: widget.familyPhoneNumberControl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'ስልክ ቁጥር',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'ET',
              onChanged: (phone) {
                widget.onFamilyPhoneNumberChanged(phone.completeNumber);
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
              controller: widget.familyBirthPlaceControl,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('የትውልድ ስፍራ')),
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
              controller: widget.familyBirthDateControl,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('የትውልድ ዘመን')),
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
                value: widget.kefleKetemaValue,
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
                  widget.familySubCityControl.text = newValue ?? '';
                  widget.onFamilySubCityChanged(newValue);
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
              controller: widget.familyWoredaControl,
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
              controller: widget.familyKebeleControl,
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
              controller: widget.familyHouseNumberControl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('የቤት ቁጥር')),
            ),
          ],
        ),
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() {
        welageImage = imageTemp;
        hasWelageImage = true;
      });

      if (!mounted) return;

      Navigator.pop(context);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
