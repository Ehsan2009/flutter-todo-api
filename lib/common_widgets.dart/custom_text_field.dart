import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.maxLines,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.blueGrey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Default line
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // No change on focus
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Fallback
        ),
        hoverColor: Colors.transparent, // Avoid hover color on web/desktop
      ),
      validator: (value) {
        if (value!.isEmpty || value.trim().length < 4) {
          return 'Please enter atleast 4 characters';
        }
        return null;
      },
    );
  }
}
