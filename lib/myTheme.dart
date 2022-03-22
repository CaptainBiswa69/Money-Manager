import 'package:flutter/material.dart';

MaterialColor PrimaryMaterialColor = MaterialColor(
  4278222976,
  <int, Color>{
    50: Color.fromRGBO(
      0,
      128,
      128,
      .1,
    ),
    100: Color.fromRGBO(
      0,
      128,
      128,
      .2,
    ),
    200: Color.fromRGBO(
      0,
      128,
      128,
      .3,
    ),
    300: Color.fromRGBO(
      0,
      128,
      128,
      .4,
    ),
    400: Color.fromRGBO(
      0,
      128,
      128,
      .5,
    ),
    500: Color.fromRGBO(
      0,
      128,
      128,
      .6,
    ),
    600: Color.fromRGBO(
      0,
      128,
      128,
      .7,
    ),
    700: Color.fromRGBO(
      0,
      128,
      128,
      .8,
    ),
    800: Color.fromRGBO(
      0,
      128,
      128,
      .9,
    ),
    900: Color.fromRGBO(
      0,
      128,
      128,
      1,
    ),
  },
);

ThemeData myTheme = ThemeData(
  fontFamily: "customFont",
  primaryColor: Color(0xff008080),
  primarySwatch: PrimaryMaterialColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Color(0xff008080),
      ),
    ),
  ),
);
