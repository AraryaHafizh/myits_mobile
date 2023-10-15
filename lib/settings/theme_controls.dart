import 'package:flutter/material.dart';
import 'package:myits_portal/settings/style.dart';
// import 'package:myits_portal/style.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ThemeSelector with ChangeNotifier {
bool isDarkMode = false;

//   Future<void> getThemePref() async {
//     final prefs = await SharedPreferences.getInstance();
//     isDarkMode = prefs.getBool('isDarkMode') ?? false;
//     notifyListeners();
//   }

//   Future<void> setThemePref(val) async {
//     final prefs = await SharedPreferences.getInstance();
//     isDarkMode = val;
//     await prefs.setBool('isDarkMode', val);
//     notifyListeners();
//   }

//   Future<void> initTheme() async {
//     await getThemePref();
//   }

//   themeChanger(val) {
//     if (val) {
//       itsBlue = const Color.fromARGB(255, 43, 107, 226);
//       itsLogo = Colors.white;
//       itsBlueShade = const Color.fromARGB(255, 74, 77, 80);
//       defaultBG = const Color.fromARGB(255, 50, 52, 54);
//       containerBG = const Color.fromARGB(255, 74, 77, 80);
//       containerWhite = const Color.fromARGB(255, 66, 68, 70);
//       white = const Color.fromARGB(255, 66, 68, 70);
//       black38 = Colors.white38;
//       black = Colors.white;
//     } else {
//       itsBlue = const Color.fromARGB(255, 4, 53, 145);
//       itsLogo = const Color.fromARGB(255, 4, 53, 145);
//       itsBlueShade = const Color.fromARGB(167, 161, 194, 255);
//       defaultBG = const Color.fromARGB(255, 237, 242, 247);
//       containerBG = const Color.fromARGB(255, 227, 232, 236);
//       containerWhite = const Color.fromARGB(255, 248, 252, 255);
//       white = Colors.white;
//       black38 = Colors.black38;
//       black = Colors.black;
//     }
//   }
// }

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(background: Colors.white));

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  // colorSchemeSeed: Colors.blue,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(background: Colors.black),
);
