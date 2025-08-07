import 'package:auranix_ai/pages/home_page.dart';
import 'package:auranix_ai/theme/colors.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(const MyApp());
}

// Device Preview for iOS/macOS
// void main() {
//   runApp(
//     DevicePreview(
//       builder: (context) =>
//       MyApp())
//     );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.submitButton),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme.copyWith(
            bodyMedium: const TextStyle(
              fontSize: 15,
              color: AppColors.whiteColor
            )
          )
        )
      ),
     

      home: const HomePage()
    );
  }
}
