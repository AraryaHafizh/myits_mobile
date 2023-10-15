import 'package:flutter/material.dart';

Color itsBlueStatic = const Color.fromARGB(255, 4, 53, 145);
Color itsBlueShadeStatic = const Color.fromARGB(50, 161, 194, 255);
Color whiteStatic = Colors.white;

Color itsBlue = const Color.fromARGB(255, 4, 53, 145);
Color itsLogo = const Color.fromARGB(255, 4, 53, 145);
Color itsBlueShade = const Color.fromARGB(167, 161, 194, 255);
Color defaultBG = const Color.fromARGB(255, 237, 242, 247);
Color containerBG = const Color.fromARGB(255, 227, 232, 236);
Color containerWhite = const Color.fromARGB(255, 248, 252, 255);
Color white = Colors.white;
Color black = Colors.black;
Color black38 = Colors.black38;

InputDecoration loginTheme = const InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      width: 2,
      color: Colors.white,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      width: 2,
      color: Colors.white,
    ),
  ),
);

InputDecoration profileSetting = InputDecoration(
  filled: true,
  fillColor: white,
  enabledBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 25, color: Colors.transparent),
  ),
  disabledBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 25, color: Colors.transparent),
  ),
  focusedBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 25, color: Colors.transparent),
  ),
  contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
);

BoxDecoration profileFieldDecoration = BoxDecoration(
  color: white, // Warna latar belakang
  borderRadius: BorderRadius.circular(15), // Membuat sudut yang membulat
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5), // Warna bayangan dan opasitas
      spreadRadius: 2, // Menyebar seberapa jauh bayangan
      blurRadius: 5, // Mengatur seberapa kabur bayangan
      offset: const Offset(0, 2), // Mengatur posisi bayangan (x, y)
    ),
  ],
);

BoxDecoration bgContainer = BoxDecoration(
  color: containerBG,
  borderRadius: BorderRadius.circular(15),
);

BoxDecoration cardsContainer = BoxDecoration(
  borderRadius: BorderRadius.circular(12),
  color: white,
);

TextStyle jakarta = const TextStyle(
  fontSize: 16,
  fontFamily: 'Jakarta',
  fontWeight: FontWeight.w600,
);

TextStyle jakartaSub = const TextStyle(
  fontSize: 13,
  fontFamily: 'Jakarta',
  fontWeight: FontWeight.w200,
);
