import 'dart:io';

import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AbalForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List kifiles;
  final TextEditingController yekerestenaNameControl;
  final TextEditingController fullNameControl;
  final TextEditingController ageControl;
  final TextEditingController genderControl;
  final TextEditingController phoneNumberControl;
  final TextEditingController birthPlaceControl;
  final TextEditingController birthDateControl;
  final TextEditingController subCityControl;
  final TextEditingController woredaControl;
  final TextEditingController kebeleControl;
  final TextEditingController houseNumberControl;
  final TextEditingController emergencyContactFullNameControl;
  final TextEditingController emergencyContactPhoneNumberControl;
  final TextEditingController kifileControl;
  String? kifileValue;
  String? kefleKetemaValue;
  String? sexValue;
  final bool isAbalFormSubmitted;
  final Function(String?) onKifileChanged;
  final Function(String?) onSexChanged;
  final Function(String?) onKefeleKetemaChanged;
  final Function(String) onPhoneNumberChanged;
  final Function(String) onEmergencyPhoneNumberChanged;

  AbalForm(
      {super.key,
      required this.formKey,
      required this.kifiles,
      required this.yekerestenaNameControl,
      required this.fullNameControl,
      required this.ageControl,
      required this.genderControl,
      required this.phoneNumberControl,
      required this.birthPlaceControl,
      required this.birthDateControl,
      required this.subCityControl,
      required this.woredaControl,
      required this.kebeleControl,
      required this.houseNumberControl,
      required this.emergencyContactFullNameControl,
      required this.emergencyContactPhoneNumberControl,
      required this.kifileControl,
      this.kifileValue,
      this.kefleKetemaValue,
      this.sexValue,
      required this.isAbalFormSubmitted,
      required this.onKifileChanged,
      required this.onSexChanged,
      required this.onKefeleKetemaChanged,
      required this.onPhoneNumberChanged,
      required this.onEmergencyPhoneNumberChanged});

  @override
  State<AbalForm> createState() => _AbalFormState();
}

class _AbalFormState extends State<AbalForm> {
  File? abalImage;
  bool hasAbalImage = false;
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
                      backgroundImage: hasAbalImage
                          ? FileImage(
                              abalImage!,
                            )
                          : Image.network('').image,
                      backgroundColor: Colors.white,
                      child: hasAbalImage
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
                                                    fontWeight: FontWeight.w500,
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
                                                    fontWeight: FontWeight.w500,
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
            !hasAbalImage && widget.isAbalFormSubmitted
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
                value: widget.kifileValue,
                isDense: true,
                hint: const Text('ክፍል'),
                isExpanded: true,
                items: widget.kifiles.map(
                  (e) {
                    return DropdownMenuItem<String>(
                        value: e['id'], child: Text(e['name']));
                  },
                ).toList(),
                onChanged: (newValue) {
                  widget.kifileControl.text = newValue ?? '';
                  widget.onKifileChanged(newValue);
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
              controller: widget.yekerestenaNameControl,
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
              controller: widget.fullNameControl,
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
              controller: widget.ageControl,
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
                  widget.genderControl.text = newValue ?? '';
                  widget.onSexChanged(newValue);
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            IntlPhoneField(
              controller: widget.phoneNumberControl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'ስልክ ቁጥር',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'ET',
              onChanged: (phone) {
                widget.onPhoneNumberChanged(phone.completeNumber);
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
              controller: widget.birthPlaceControl,
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
              controller: widget.birthDateControl,
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
                  widget.subCityControl.text = newValue ?? '';
                  widget.onKefeleKetemaChanged(newValue);
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
              controller: widget.woredaControl,
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
              controller: widget.kebeleControl,
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
              controller: widget.houseNumberControl,
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
              controller: widget.emergencyContactFullNameControl,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('የአደጋ ጊዜ ተጠሪ')),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            IntlPhoneField(
              controller: widget.emergencyContactPhoneNumberControl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'የአደጋ ጊዜ ተጠሪ ስልክ ቁጥር',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'ET',
              onChanged: (phone) {
                widget.onEmergencyPhoneNumberChanged(phone.completeNumber);
              },
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
        abalImage = imageTemp;
        hasAbalImage = true;
      });

      if (!mounted) return;

      Navigator.pop(context);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
