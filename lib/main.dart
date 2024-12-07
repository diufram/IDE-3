import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ide3/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
            title: 'Agenda Electronica',
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: GoogleFonts.comicNeue().fontFamily,
              textTheme: TextTheme(
                displayLarge: TextStyle(fontSize: 60.sp), // Muy grande
                displayMedium: TextStyle(fontSize: 48.sp), // Grande
                displaySmall: TextStyle(fontSize: 40.sp), // Mediano
                headlineLarge: TextStyle(fontSize: 34.sp), // Título grande
                headlineMedium: TextStyle(fontSize: 28.sp), // Título medio
                headlineSmall: TextStyle(fontSize: 24.sp), // Título pequeño
                titleLarge: TextStyle(fontSize: 20.sp), // Subtítulo grande
                titleMedium: TextStyle(fontSize: 18.sp), // Subtítulo mediano
                titleSmall: TextStyle(fontSize: 16.sp), // Subtítulo pequeño
                bodyLarge: TextStyle(fontSize: 16.sp), // Texto de cuerpo
                bodyMedium: TextStyle(fontSize: 14.sp), // Cuerpo mediano
                bodySmall: TextStyle(fontSize: 12.sp), // Cuerpo pequeño
                labelLarge: TextStyle(fontSize: 16.sp), // Etiqueta grande
                labelMedium: TextStyle(fontSize: 14.sp), // Etiqueta mediana
                labelSmall: TextStyle(fontSize: 12.sp), // Etiqueta pequeña
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: Home());
      },
    );
  }
}
