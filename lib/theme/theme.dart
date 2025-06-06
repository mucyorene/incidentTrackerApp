import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

const primaryColor = Color(0xFFFE8C00); //main
const primarySurfaceColor = Color(0xFFFFF6D8);
const primaryColorDark = Color(0xFF052B66);
const secondaryColor = Color(0xFFFFD33C); //Secondary
const thirdColor = Color(0xFFFAC577);
const greenColor = Color(0xFF00C057);
const skyBlueColor = Color(0xFFEAF0F9);
const darkRedColor = Color(0xFFA71818);

//success
const successColor = Color(0xFF50CD89); //success color
const surfaceGreenColor = Color(0xFFF2FFF8);
const borderGreenColor = Color(0xFFC5EED8);
const pressedGreenColor = Color(0xFF28593f);

//Error
const errorRedColor = Color(0xFFF14141);
const surfaceRedColor = Color(0xFFFFF2F2);
const borderRedColor = Color(0xFFFAC0C0);
const pressedRedColor = Color(0xFF802A2A);

//Info
const errorInfoColor = Color(0xFF7239EA);
const surfaceInfoColor = Color(0xFFF6F2FF);
const borderInfoColor = Color(0xFFD0BDF8);
const pressedInfoColor = Color(0xFF3F2478);

const darkColor = Color(0xff374957);

const Map<int, Color> myPalette = {
  50: Color.fromRGBO(254, 140, 0, .1),
  100: Color.fromRGBO(254, 140, 0, .2),
  200: Color.fromRGBO(254, 140, 0, .3),
  300: Color.fromRGBO(254, 140, 0, .4),
  400: Color.fromRGBO(254, 140, 0, .5),
  500: Color.fromRGBO(254, 140, 0, .6),
  600: Color.fromRGBO(254, 140, 0, .7),
  700: Color.fromRGBO(254, 140, 0, .8),
  800: Color.fromRGBO(254, 140, 0, .9),
  900: Color.fromRGBO(254, 140, 0, 1),
};

const MaterialColor customPalette = MaterialColor(0xFFFE8C00, myPalette);

var lightTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  primaryColor: secondaryColor,
  appBarTheme: const AppBarTheme(elevation: 0),
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: WidgetStateProperty.all(const TextStyle(fontSize: 13)),
  ),
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,
    accentColor: secondaryColor,
    primarySwatch: customPalette,
  ).copyWith(secondary: secondaryColor),
  fontFamily: GoogleFonts.montserrat().fontFamily,
);
