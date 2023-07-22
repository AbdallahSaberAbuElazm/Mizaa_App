import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
      // primarySwatch: ColorConstants.mainColor,
      scaffoldBackgroundColor: ColorConstants.backgroundContainer,
      primaryColor: ColorConstants.mainColor,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0),
      bottomAppBarColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          hintStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'Noto Kufi Arabic',
          )),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: ColorConstants.mainColor),
      textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 23,
            color: ColorConstants.blackColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Noto Kufi Arabic',
          ),
          headline2: const TextStyle(
              letterSpacing: -1.0,
              fontSize: 40,
              color: Colors.black,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.bold),
          headline3: const TextStyle(
              letterSpacing: -1.0,
              fontSize: 32,
              color: Colors.black,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.bold),
          headline4: TextStyle(
            color: ColorConstants.greyColor,
            fontSize: 13,
            fontFamily: 'Noto Kufi Arabic',
          ),
          headline5: TextStyle(
              color: ColorConstants.black0,
              fontSize: 13,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.w600),
          headline6: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.w500),
          subtitle1: TextStyle(
              color: ColorConstants.black0,
              fontSize: 14,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.w400),
          subtitle2: TextStyle(
              color: ColorConstants.greyColor,
              fontSize: 13,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.w400),
          bodyText1: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.w400),
          bodyText2: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.w400),
          button: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.w600),
          caption: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.w400),
          overline: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 10,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.5)));

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorConstants.darkMainColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorConstants.bottomAppBarDarkColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    bottomAppBarColor: ColorConstants.bottomAppBarDarkColor,
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        hintStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'Noto Kufi Arabic',
        )),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.white),
    textTheme: TextTheme(
        headline1: const TextStyle(
          fontSize: 23,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Noto Kufi Arabic',
        ),
        headline2: TextStyle(
            letterSpacing: -1.0,
            fontSize: 40,
            color: Colors.grey.shade50,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.bold),
        headline3: TextStyle(
            letterSpacing: -1.0,
            fontSize: 32,
            color: Colors.grey.shade50,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.bold),
        headline4: TextStyle(
            letterSpacing: -1.0,
            color: Colors.grey.shade50,
            fontSize: 28,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w600),
        headline5: TextStyle(
            letterSpacing: -1.0,
            color: Colors.grey.shade50,
            fontSize: 24,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w500),
        headline6: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 18,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w500),
        subtitle1: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 14,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w500),
        subtitle2: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 13,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w500),
        bodyText1: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 16,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w400),
        bodyText2: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 14,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w400),
        button: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w600),
        caption: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 12,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w500),
        overline: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 10,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w400)),
  );
}
