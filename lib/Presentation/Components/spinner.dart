import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner extends StatelessWidget {
  final String text;
  const Spinner({super.key, required this.text});

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
