import 'package:flutter/material.dart';

class Themes {
  static final darkTheme = ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(backgroundColor: primaryColor),
      scaffoldBackgroundColor: primaryColorDark,
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: secondaryColor, selectionHandleColor: secondaryColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: primaryColor, // background (button) color
          onPrimary: textColor,
          minimumSize:const Size(250, 55),
          side: BorderSide(
            width: 1,
            color: secondaryColor,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      )

      // Define the default font family.
      // fontFamily: 'Roboto',
      );
}

Color primaryColor = const Color(0xFF565564);
Color primaryColorDark = const Color(0xFF222D3B);
Color primaryColorLight = const Color(0xFF656576);
Color secondaryColor = const Color(0xFFD2D2DC);
Color textColor = const Color(0xFFFFFFFF);
