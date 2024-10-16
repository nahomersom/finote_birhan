import 'dart:io';

import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/controllers/form_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({super.key, required this.imageType});
  final String imageType;
  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  final formController = Get.put(FormController());
  // Initialize the controller
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                blurRadius: 8.0, // Softness of the shadow
                spreadRadius: 2.0, // How wide the shadow spreads
                offset: const Offset(2, 4), // Position of the shadow (x, y)
              ),
            ],
          ),
          child: CircleAvatar(
              backgroundImage: formController.getImage(widget.imageType) != null
                  ? FileImage(
                      formController.getImage(widget.imageType)!,
                    )
                  : Image.network('').image,
              backgroundColor: Colors.white,
              child: formController.getImage(widget.imageType) != null
                  ? const SizedBox()
                  : ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xff6115da), Color(0xffbd2aec)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.person_outline_outlined,
                        size: 60,
                        color: ColorResources.secondaryColor,
                      ),
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
                                        color: ColorResources.textColor)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                await onImagePicked(ImageSource.camera);
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xffFAF3FB),
                                    child: ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                        colors: [
                                          Color(0xff6115da),
                                          Color(0xffbd2aec)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
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
                                              color: ColorResources.textColor))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                await onImagePicked(ImageSource.gallery);
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xffFAF3FB),
                                    child: ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                        colors: [
                                          Color(0xff6115da),
                                          Color(0xffbd2aec)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds),
                                      child: const Icon(
                                        Icons.photo_size_select_actual_outlined,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
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
                                              color: ColorResources.textColor))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
            child: Container(
              width: 45.0,
              height: 45.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Make the container a circle
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff6115da),
                    Color(0xffbd2aec)
                  ], // Gradient colors
                  stops: [0, 1],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    blurRadius: 8.0, // Softness of the shadow
                    spreadRadius: 2.0, // How wide the shadow spreads
                    offset: const Offset(2, 4), // Position of the shadow (x, y)
                  ),
                ],
              ),
              child: const CircleAvatar(
                backgroundColor:
                    Colors.transparent, // Keep the CircleAvatar transparent
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> onImagePicked(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile == null) return;

      setState(() {
        final pickedImage = File(pickedFile.path);

        formController.setImage(widget.imageType, pickedImage);
      });

      if (!mounted) return;

      Navigator.pop(context); // Close the image picker after picking
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
