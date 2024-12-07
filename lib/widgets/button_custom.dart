import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.color,
      required this.colorText,
      required this.fontSize});

  final VoidCallback onPressed;
  final String text;
  final Color color;
  final Color colorText;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,

        elevation: 5, // Elevación del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 30, vertical: 15), // Padding interno
      ),
      child: Text(
        text,
        style: TextStyle(color: colorText, fontSize: fontSize.sp),
      ),
    );
  }
}
