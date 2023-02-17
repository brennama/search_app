

import 'package:flutter/material.dart';

final ThemeData appTheme = _appTheme();

//Define Base theme for app
ThemeData _appTheme() {
  final ThemeData base = ThemeData(
  );

  return base.copyWith(
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.white, fontFamily: 'Avenir'),
    ),
    highlightColor: Colors.grey,
    primaryColorLight: Colors.white,
    cardTheme: CardTheme(
      color: AppColors.darkGray,
    ),
    scaffoldBackgroundColor: AppColors.darkGray,
    colorScheme: base.colorScheme.copyWith(
      primary: Colors.black,


    ),



  );
}



class AppColors {
  static MaterialAccentColor get blue => _bluePrimaryColor.toMaterialAccentColor();
  static MaterialAccentColor get green => _greenPrimaryColor.toMaterialAccentColor();
  static MaterialAccentColor get red => _redPrimaryColor.toMaterialAccentColor();
  static MaterialAccentColor get darkGray => _darkGrayPrimaryColor.toMaterialAccentColor();

  static const Color _bluePrimaryColor = Color(0xFF0084ff);
  static const Color _greenPrimaryColor = Color(0xFF00BA84);
  static const Color _redPrimaryColor = Color(0xFFFF004A);
  static const Color _darkGrayPrimaryColor = Color(0xFF171717);

}

extension _Material on Color {
  Map<int, Color> _toSwatch() => {
    50: withOpacity(0.1),
    100: withOpacity(0.2),
    200: withOpacity(0.3),
    300: withOpacity(0.4),
    400: withOpacity(0.5),
    500: withOpacity(0.6),
    600: withOpacity(0.7),
    700: withOpacity(0.8),
    800: withOpacity(0.9),
    900: this,
  };



  MaterialAccentColor toMaterialAccentColor() => MaterialAccentColor(
    value,
    _toSwatch(),
  );
}