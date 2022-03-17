import 'package:flutter/material.dart';

MaterialColor PrimaryMaterialColor = const MaterialColor(
  4282299529,
  <int, Color>{
    50: Color.fromRGBO(
      62,
      180,
      137,
      .1,
    ),
    100: Color.fromRGBO(
      62,
      180,
      137,
      .2,
    ),
    200: Color.fromRGBO(
      62,
      180,
      137,
      .3,
    ),
    300: Color.fromRGBO(
      62,
      180,
      137,
      .4,
    ),
    400: Color.fromRGBO(
      62,
      180,
      137,
      .5,
    ),
    500: Color.fromRGBO(
      62,
      180,
      137,
      .6,
    ),
    600: Color.fromRGBO(
      62,
      180,
      137,
      .7,
    ),
    700: Color.fromRGBO(
      62,
      180,
      137,
      .8,
    ),
    800: Color.fromRGBO(
      62,
      180,
      137,
      .9,
    ),
    900: Color.fromRGBO(
      62,
      180,
      137,
      1,
    ),
  },
);

ThemeData myTheme = ThemeData(
  fontFamily: "customFont",
  primaryColor: const Color(0xff3eb489),
  primarySwatch: PrimaryMaterialColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        const Color(0xff3eb489),
      ),
    ),
  ),
);
