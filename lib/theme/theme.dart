import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

const primaryColor = Color(0xFFFE8C00); //main
const primarySurfaceColor = Color(0xFFFFF6D8);
const secondaryColor = Color(0xFFFFD33C); //Secondary
const thirdColor = Color(0xFFFAC577);
const greenColor = Color(0xFF00C057);

//success
const successColor = Color(0xFF50CD89); //success color
const surfaceGreenColor = Color(0xFFF2FFF8);
const borderGreenColor = Color(0xFFC5EED8);
const pressedGreenColor = Color(0xFF28593f);

//Error
const errorRedColor = Color(0xFFF14141);

//Info
const errorInfoColor = Color(0xFF7239EA);

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
  appBarTheme: AppBarTheme(
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.transparent,
    ),
    centerTitle: true,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    iconTheme: IconThemeData(color: Colors.white),
  ),
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
