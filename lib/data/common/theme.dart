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
      useMaterial3: true);
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
      useMaterial3: true);
}

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);

enum ColorSeed {
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

ThemeData m3DarkThemeData(BuildContext context) {
  return ThemeData(
    colorSchemeSeed: ColorSeed.baseColor.color,
    useMaterial3: true,
    brightness: Brightness.dark,
  );
}

ThemeData m3LightThemeData(BuildContext context) {
  return ThemeData(
    colorSchemeSeed: ColorSeed.baseColor.color,
    useMaterial3: true,
    brightness: Brightness.light,
  );
}
