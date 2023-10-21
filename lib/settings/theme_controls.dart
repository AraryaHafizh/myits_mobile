import 'package:flutter/material.dart';
import 'package:myits_portal/settings/style.dart';
// import 'package:myits_portal/style.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ThemeSelector with ChangeNotifier {
//   bool isDarkMode = false;

//   Future<bool> getThemePref() async {
//     final prefs = await SharedPreferences.getInstance();
//     isDarkMode = prefs.getBool('isDarkMode') ?? false;
//     return isDarkMode;
//   }

//   Future<void> setThemePref(val) async {
//     final prefs = await SharedPreferences.getInstance();
//     isDarkMode = val;
//     await prefs.setBool('isDarkMode', val);
//     notifyListeners();
//   }

//   Future<void> initTheme() async {
//     isDarkMode = await getThemePref();
//     await getThemePref();
//   }
// }

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: itsBlue,
      outline: black38,
      onPrimary: black38,
      onSecondary: black,
      tertiary: itsLogo,
      background: defaultBG,
      primaryContainer: containerBG,
      onSecondaryContainer: white,
      secondaryContainer: containerWhite,
    ),
    textTheme: TextTheme(
      titleLarge: jakarta.copyWith(fontSize: 25, color: black),
      bodyMedium: jakarta.copyWith(fontSize: 14, color: itsBlue),
      bodySmall: jakarta.copyWith(fontSize: 12, color: black38),
    ),
    iconTheme: IconThemeData(color: black),
    navigationBarTheme: NavigationBarThemeData(
        indicatorColor: itsBlueShade, shadowColor: itsBlueShade),
    inputDecorationTheme: InputDecorationTheme(fillColor: white),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: itsYellowStatic,
      selectionHandleColor: itsYellowStatic,
    ));

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: itsBlueDark,
    outline: black38Dark,
    onPrimary: black38Dark,
    onSecondary: blackDark,
    tertiary: itsLogoDark,
    background: defaultBGDark,
    primaryContainer: containerBGdark,
    onSecondaryContainer: whiteDark,
    secondaryContainer: containerWhiteDark,
  ),
  textTheme: TextTheme(
    titleLarge: jakarta.copyWith(fontSize: 25, color: blackDark),
    bodyMedium: jakarta.copyWith(fontSize: 14, color: itsBlueDark),
    bodySmall: jakarta.copyWith(fontSize: 12, color: black38Dark),
  ),
  iconTheme: IconThemeData(color: blackDark),
  navigationBarTheme: NavigationBarThemeData(indicatorColor: itsBlueShadeDark),
  inputDecorationTheme: InputDecorationTheme(fillColor: whiteDark),
);
