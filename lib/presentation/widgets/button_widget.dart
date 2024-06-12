import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.textButton,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.colorText,
    this.onPressed,
  });
  final String textButton;
  final double fontSize;
  final double width;
  final double height;
  final FontWeight fontWeight;
  final Color color;
  final Color colorText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          textButton,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colorText,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}