import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryLightColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme,
    cardColor: kCardLightColor,
    indicatorColor: kPrimaryLightColor,
    iconTheme: const IconThemeData(color: kContentColorLightTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorLightTheme),
    colorScheme: const ColorScheme.light(
      primary: kPrimaryLightColor,
      secondary: kSecondaryLightColor,
      error: kErrorColor,
    ).copyWith(background: kBackgroundLightColor),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryDarkColor,
    scaffoldBackgroundColor: kContentColorLightTheme,
    appBarTheme: appBarTheme,
    cardColor: kCardDarkColor,
    indicatorColor: kPrimaryDarkColor,
    iconTheme: const IconThemeData(color: kContentColorDarkTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorDarkTheme),
    colorScheme: const ColorScheme.dark()
        .copyWith(
          primary: kPrimaryDarkColor,
          secondary: kSecondaryDarkColor,
          error: kErrorColor,
        )
        .copyWith(background: kBackgroundDarkColor),
  );
}

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
