import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextCustom extends StatelessWidget {
  const TextCustom({super.key, required this.text, required this.fontSize});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize.sp,
            foreground: Paint()
              ..style = PaintingStyle.stroke // Define el estilo como contorno
              ..strokeWidth = 3 // Grosor del contorno
              ..color = Colors.black, // Color del contorno
          ),
        ),
        // Texto relleno (superpuesto)
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize.sp,
            color: Colors.white, // Color del relleno
          ),
        ),
      ],
    );
  }
}
