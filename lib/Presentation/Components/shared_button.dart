import 'package:finote_birhan_mobile/Data/Data%20Providers/light_theme.dart';
import 'package:flutter/material.dart';

class SharedButton extends StatelessWidget {
  const SharedButton(
      {super.key, required this.buttonText, required this.onTap});
  final String buttonText;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Theme(
        data: lightTheme,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xff6115da), Color(0xffbd2aec)],
              stops: [0, 1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onTap,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Center(
                  child: Text(
                    buttonText,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
