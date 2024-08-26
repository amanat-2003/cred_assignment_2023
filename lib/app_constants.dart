import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData appThemeData() => ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme:
            ColorScheme.fromSeed(seedColor: AppColors.bottomNavBarButtonColor),
        useMaterial3: true,
      );
}

class AppColors {
  const AppColors._();
  static const Color scaffoldBackgroundColor =
      Color(0xFF0c151c); // Dark background
  static const Color topCircularButtonBackgroundColor = Color(0xFF1B242A);
  static const Color topCircularButtonForegroundColor = Color(0xFFA5ACAC);
  static const Color bottomNavBarButtonColor = Color(0xFF3e4da7);
  static const Color bottomNavBarTextColor = Color(0xFFfed3c7);
  static const Color emiCardColor1 = Color(0xFF4d3841);
  static const Color emiCardColor2 = Color(0xFF867e99);
  static const Color emiCardColor3 = Color(0xFF5c7697);
  static const Color bigBlueTextColor = Color(0xFF89adb8);
  static const Color smallBlueTextColor = Color(0xFF57636c);
  static const Color greyTextColor = Color(0xFF949897);
  static const Color darkGreyTextColor = Color(0xFF7a7c80);
  static const Color lightGreyTextColor = Color(0xFFacb0ad);
  static const Color greenTextColor = Color(0xFF89b27e);
  static const Color darkOrangeColor = Color(0xFFdf9574);
  static const Color lightOrangeColor = Color(0xFFffebe2);
  static const Color sliderBorderColor = Color(0xFFfec0b0);
  static const Color sliderBlackColor = Color(0xFF383030);
  static const Color sliderGreenColor = Color(0xFF1cf2ce);
  static const Color whiteCardColor = Color(0xFFfefffe);
  static const Color base1Color = Color(0xFF111922);
  static const Color base2Color = Color(0xFF17212c);
  static const Color base3Color = Color(0xFF1d2732);
  static const Color text1InactiveColor = Color(0xFF334248);
  static const Color text2InactiveColor = Color(0xFF39454e);
  static const Color lighterOrangeColor = Color.fromARGB(255, 255, 237, 229);
  static const Color blackColor = Color.fromARGB(255, 0, 0, 0);
  static const Color whiteColor = Color.fromARGB(255, 255, 255, 255);

  //view 2
  static const Color outlineButtonColor = Color(0xFFa6c8d9);
}
