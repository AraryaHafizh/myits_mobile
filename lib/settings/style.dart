import 'package:flutter/material.dart';

// Static Colors
Color itsBlueStatic = const Color.fromARGB(255, 4, 53, 145);
Color itsBlueShadeStatic = const Color.fromARGB(55, 161, 194, 255);
Color whiteStatic = Colors.white;
Color itsYellowStatic = const Color.fromARGB(255, 255, 221, 27);

// Responsive Colors
Color defaultBG = const Color.fromARGB(255, 237, 242, 247);
Color defaultBGDark = const Color.fromARGB(255, 50, 52, 54);

Color containerBG = const Color.fromARGB(255, 227, 232, 236);
Color containerBGdark = const Color.fromARGB(255, 74, 77, 80);

Color containerWhite = const Color.fromARGB(255, 248, 252, 255);
Color containerWhiteDark = const Color.fromARGB(255, 66, 68, 70);

Color black = Colors.black;
Color blackDark = Colors.white;

Color itsBlue = const Color.fromARGB(255, 4, 53, 145);
Color itsBlueDark = const Color.fromARGB(255, 43, 107, 226);

Color itsBlueShade = const Color.fromARGB(167, 161, 194, 255);
Color itsBlueShadeDark = const Color.fromARGB(255, 74, 77, 80);

Color itsLogo = const Color.fromARGB(255, 4, 53, 145);
Color itsLogoDark = white;

Color black38 = Colors.black38;
Color black38Dark = Colors.white38;

Color white = Colors.white;
Color whiteDark = const Color.fromARGB(255, 66, 68, 70);

// ---------- input decoration theme
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

InputDecoration profileSetting = const InputDecoration(
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 25, color: Colors.transparent),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 25, color: Colors.transparent),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 25, color: Colors.transparent),
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
);

// ---------- box decoration theme
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

// // ---------- Text preset
TextStyle jakarta = const TextStyle(
  fontSize: 16,
  fontFamily: 'Jakarta',
  fontWeight: FontWeight.w600,
);
