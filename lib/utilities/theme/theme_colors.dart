import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._privateConstructor();

  static final AppTheme _instance = AppTheme._privateConstructor();

  factory AppTheme() {
    return _instance;
  }

  IThemeColors theme = LightTheme();
}

abstract class IThemeColors {
  Color get backgroundColor;

  Color get primaryTextColor;

  Color get secondaryTextColor;

  Color get cardColor;

  Color get orangeColor;

  Color get greenColor;

  Color get whiteColor;

  Color get violetColor;

  Color get blackColor;
}


/*
* Light Theme color palette
* */
class LightTheme extends IThemeColors {
  @override
  Color get backgroundColor => const Color(0xFFE3E9F2);

  @override
  Color get primaryTextColor => Colors.black;

  @override
  Color get secondaryTextColor => Colors.grey;

  @override
  Color get cardColor => const Color(0xFFB9D4FD);

  @override
  Color get orangeColor => const Color(0xFFFDD5C2);

  @override
  Color get greenColor => const Color(0xffBFD8AF);

  @override
  Color get whiteColor => Colors.white;

  @override
  Color get violetColor => const Color(0xFF9195F6);

  @override
  Color get blackColor => Colors.black;
}


/*
* Dark theme color palette
* */
class DarkTheme extends IThemeColors {
  @override
  Color get backgroundColor => const Color(0xFF070F2B);

  @override
  Color get primaryTextColor => Colors.white;

  @override
  Color get secondaryTextColor => Colors.grey;

  @override
  Color get cardColor => const Color(0xFFB9D4FD);

  @override
  Color get orangeColor => const Color(0xFFFDD5C2);

  @override
  Color get greenColor => const Color(0xffBFD8AF);

  @override
  Color get whiteColor => Colors.white;

  @override
  Color get violetColor => const Color(0xFF9195F6);

  @override
  Color get blackColor => Colors.black;
}
