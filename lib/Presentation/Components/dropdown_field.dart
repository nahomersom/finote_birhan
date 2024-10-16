import 'package:flutter/material.dart';

class sharedDropdownField extends StatelessWidget {
  const sharedDropdownField(
      {super.key,
      required this.value,
      required this.items,
      required this.onChanged,
      required this.hintText});

  final String? value;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?)? onChanged;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          // Background color
          fillColor: Colors.white,
          filled: true,

          // Remove the border but keep the border radius
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Rounded border
            borderSide: BorderSide.none, // No visible border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Rounded border
            borderSide:
                BorderSide(color: Colors.transparent), // Invisible border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Rounded border
            borderSide:
                BorderSide(color: Colors.transparent), // Invisible border
          ),

          // Control padding inside the dropdown
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'ይህ ቦታ መሞላት አለበት'; // Validation message
          }
          return null;
        },
        value: value,
        isDense: true,
        hint: Text(hintText),
        isExpanded: true,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
