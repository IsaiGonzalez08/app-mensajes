import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatelessWidget {
  const MyTextFieldWidget({
    super.key,
    required this.text,
    required this.width,
    required this.controllerTextField,
  });
  final String text;
  final double width;
  final TextEditingController controllerTextField;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide.none,
          ),
          hintText: text,
          hintStyle: const TextStyle(
              fontSize: 12,
              color: Color(0xFFB8B8B8),
              fontWeight: FontWeight.w500),
          filled: true,
          fillColor: const Color(0xFFEDEDED),
        ),
        controller: controllerTextField,
      ),
    );
  }
}