import 'package:flutter/material.dart';

class SharedTextField extends StatelessWidget {
  const SharedTextField(
      {super.key, required this.formController, required this.label});

  final TextEditingController formController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'ይህ ቦታ መሞላት አለበት'; // Validation message
        }
        return null;
      },
      controller: formController,
      decoration: InputDecoration(
        // Background color
        fillColor: Colors.white,
        filled: true,

        // Remove the default border but keep the border radius
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none, // No visible border
        ),

        // Remove border when the field is enabled or focused but keep the border radius
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent), // Invisible border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent), // Invisible border
        ),

        // Content padding
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),

        // Label text style
        labelText: label,
        labelStyle:
            const TextStyle(color: Colors.black), // Ensure label remains black
      ),

      // Text style for input text
      style: const TextStyle(color: Colors.black),
    );
  }
}
