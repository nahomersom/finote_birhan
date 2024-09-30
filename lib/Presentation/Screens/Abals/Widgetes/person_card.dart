import 'package:flutter/material.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';

import '../../../../Data/Models/abal.dart';

class AbalCard extends StatelessWidget {
  final AbalRegistrationModel abal;
  final Function()? onPress;
  const AbalCard({Key? key, required this.abal, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 23,
        decoration: BoxDecoration(
            color: ColorResources.lightSecondaryColor,
            borderRadius: BorderRadius.circular(30)),
        child: AspectRatio(
          aspectRatio: 0.63,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: abal.abal.fullName,
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/spinner.gif',
                      image: abal.abal.imagePath,
                      fit: BoxFit.cover),
                ),
              ),
              // Padding(
              //     padding:
              //         EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!),
              //     child: TitleText(title: product.title)),
              // SizedBox(
              //   height: SizeConfig.defaultSize! / 2,
              // ),
              // Text("${product.price}")
            ],
          ),
        ),
      ),
    );
  }
}
