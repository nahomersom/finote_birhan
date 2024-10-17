import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField(
      {super.key,
      required this.label,
      required this.controller,
      required this.onChanged});
  final String label;
  final TextEditingController controller;
  final ValueChanged<PhoneNumber>? onChanged;
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      autovalidateMode: AutovalidateMode.always,
      invalidNumberMessage: 'ትክክለኛ ስልክ ያስገቡ',
      validator: (value) {
        if (value == null || value.number.isEmpty) {
          return 'ይህ ቦታ መሞላት አለበት'; // Validation message
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,

        // Background color
        fillColor: Colors.white,
        filled: true,

        // Remove visible border but keep rounded corners
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
          borderSide: BorderSide.none, // No visible border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
          borderSide:
              const BorderSide(color: Colors.transparent), // Invisible border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
          borderSide:
              const BorderSide(color: Colors.transparent), // Invisible border
        ),
        // Control padding
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
      ),
      initialCountryCode: 'ET', // Ethiopia as the default country code
      onChanged: onChanged,
    );
  }
}
