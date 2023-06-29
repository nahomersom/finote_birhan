import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hisnate_kifele/Data/Data%20Providers/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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

class _RegistrationScreenState extends State<RegistrationScreen> with TickerProviderStateMixin {
  int currentStep = 0;
  final firstName = TextEditingController();
  final familyFirstName = TextEditingController();
  final comment = TextEditingController();
  final _phoneNumberControl = TextEditingController();
  String  phoneNumber =  "";
  String? sexValue;
  String? kefleKetemaValue;

  File? image;
  bool hasImage = false;

  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'የአባል መመዝገቢያ',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(),
          ),
        ),
        body: SafeArea(
          child: Theme(
            data: ThemeData(
              iconTheme: Theme.of(context).iconTheme.copyWith(size: 18.0),
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    tertiary: Colors.red,
                    primary: ColorResources.secondaryColor,
                    onSurface: ColorResources.secondaryColor.withOpacity(0.02),
                    background: Colors.red,
                    secondary: ColorResources.secondaryColor,
                  ),
            ),
            child: Stepper(
              elevation: 0,
              type: StepperType.horizontal,
              steps: registrationSteps(sizeH, sizeW),
              onStepTapped: (step) => setState(() => currentStep = step),
              currentStep: currentStep,
              onStepContinue: () {
                final lastStep =
                    currentStep == registrationSteps(sizeH, sizeW).length - 1;
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
                    registrationSteps(sizeH, sizeW).length - 1;
                return Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: details.onStepContinue,
                        child: Text(
                          isLastStep ? 'አጠናቅ' : 'ቀጣይ',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: ColorResources.primaryColor),
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
            ),
          ),
        ));
  }

  List<Step> registrationSteps(height, width) => [
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
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      SizedBox(
                        height: 130,
                        width: 130,
                        child: CircleAvatar(
                            backgroundImage: hasImage
                                ? FileImage(
                                    image!,
                                  )
                                : Image.network('').image,
                            backgroundColor: Color(0xffE6E6E6),
                            child: hasImage
                                ? SizedBox()
                                : const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Color(0xffCCCCCC),
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
                                            await pickImage(ImageSource.camera);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.camera_alt_outlined,
                                                size: 25,
                                                color: ColorResources.textColor,
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
                                                          color: ColorResources
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
                                                ImageSource.gallery);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .photo_size_select_actual_outlined,
                                                size: 25,
                                                color: ColorResources.textColor,
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
                              backgroundColor: ColorResources.secondaryColor,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: ColorResources.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: firstName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('የክርስትና ስም')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: firstName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('ሙሉ ስም')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: firstName,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('ዕድሜ')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: sexValue,
                        isDense: true,
                        hint:const Text('ጾታ'),
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("ወንድ")),
                          DropdownMenuItem(
                              value: "Female",
                              child: Text("ሴት")),
                        ],
                        onChanged: (newValue) {
                          setState(() {
                            sexValue = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  IntlPhoneField(
                    controller: _phoneNumberControl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration:  const InputDecoration(
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
                    controller: firstName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('የትውልድ ስፍራ')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: firstName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('የትውልድ ዘመን')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: kefleKetemaValue,
                        isDense: true,
                        hint:const Text('ክፈለ ከተማ'),
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "ledeta", child: Text("ልደታ")),
                          DropdownMenuItem(
                              value: "addis ketema",
                              child: Text("አዲስ ከተማ")),
                          DropdownMenuItem(
                              value: "arada",
                              child: Text("አራዳ")),
                        ],
                        onChanged: (newValue) {
                          setState(() {
                            sexValue = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: firstName,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('ወረዳ')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: firstName,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('ቀበሌ')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: firstName,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('የቤት ቁጥር')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),

                  TextFormField(
                    controller: firstName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('የአደጋ ጊዜ ተጠሪ')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  IntlPhoneField(
                    controller: _phoneNumberControl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration:  const InputDecoration(
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
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      SizedBox(
                        height: 130,
                        width: 130,
                        child: CircleAvatar(
                            backgroundImage: hasImage
                                ? FileImage(
                              image!,
                            )
                                : Image.network('').image,
                            backgroundColor: Color(0xffE6E6E6),
                            child: hasImage
                                ? SizedBox()
                                : const Icon(
                              Icons.person,
                              size: 60,
                              color: Color(0xffCCCCCC),
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
                                            await pickImage(ImageSource.camera);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.camera_alt_outlined,
                                                size: 25,
                                                color: ColorResources.textColor,
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
                                                      color: ColorResources
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
                                                ImageSource.gallery);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .photo_size_select_actual_outlined,
                                                size: 25,
                                                color: ColorResources.textColor,
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
                              backgroundColor: ColorResources.secondaryColor,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: ColorResources.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: firstName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('የክርስትና ስም')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: firstName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('ሙሉ ስም')),

                  ),   SizedBox(
                    height: height * 0.02,
                  ),

                  InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: sexValue,
                        isDense: true,
                        hint:const Text('ከአባሉ ጋር ያለው ግንኙነት'),
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "mother", child: Text("እናት")),
                          DropdownMenuItem(
                              value: "father",
                              child: Text("አባት")),
                          DropdownMenuItem(
                              value: "brother",
                              child: Text("ወንድም")),
                          DropdownMenuItem(
                              value: "sister",
                              child: Text("አህት")),
                          DropdownMenuItem(
                              value: "Female",
                              child: Text("ዘመድና")),
                        ],
                        onChanged: (newValue) {
                          setState(() {
                            sexValue = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: firstName,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('ዕድሜ')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: sexValue,
                        isDense: true,
                        hint:const Text('ጾታ'),
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("ወንድ")),
                          DropdownMenuItem(
                              value: "Female",
                              child: Text("ሴት")),
                        ],
                        onChanged: (newValue) {
                          setState(() {
                            sexValue = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  IntlPhoneField(
                    controller: _phoneNumberControl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration:  const InputDecoration(
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
                    controller: firstName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('የትውልድ ስፍራ')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: firstName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('የትውልድ ዘመን')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: kefleKetemaValue,
                        isDense: true,
                        hint:const Text('ክፈለ ከተማ'),
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "ledeta", child: Text("ልደታ")),
                          DropdownMenuItem(
                              value: "addis ketema",
                              child: Text("አዲስ ከተማ")),
                          DropdownMenuItem(
                              value: "arada",
                              child: Text("አራዳ")),
                        ],
                        onChanged: (newValue) {
                          setState(() {
                            sexValue = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: firstName,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('ወረዳ')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: firstName,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('ቀበሌ')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: firstName,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('የቤት ቁጥር')),
                  ),


                ],
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
                    controller: comment,
                    decoration: const InputDecoration(label: Text('አስተያየት')),
                  )
                ],
              ),
            ))
      ];
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);

      print('********************8file');
      print(image);
      setState(() => {this.image = imageTemp, hasImage = true});
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
