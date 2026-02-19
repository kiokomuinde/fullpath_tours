import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
import 'widgets/common_widgets.dart'; // This imports our design system colors

void main() {
  runApp(const FullpathToursApp());
}

class FullpathToursApp extends StatelessWidget {
  const FullpathToursApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fullpath.tours',
      debugShowCheckedModeBanner: false, // Removes the debug ribbon in the top right
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.savannahSunset,
          background: AppColors.sand, // Applies our warm sand color globally
        ),
        useMaterial3: true,
        // You can easily swap 'Roboto' for Google Fonts later to enhance the typography
        fontFamily: 'Roboto', 
      ),
      home: const LandingPage(), // Sets our custom UI as the entry point
    );
  }
}