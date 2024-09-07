// import 'package:decoder/util/colors_app.dart';
import 'package:flutter/material.dart';

// ThemeData get lightTheme => ThemeData.light().copyWith(
//       appBarTheme: AppBarTheme().copyWith(
//         backgroundColor: kBackgroundLightColor,
//         elevation: .5,
//       ),
//       scaffoldBackgroundColor: kBackgroundLightColor,
//     );
// ThemeData get darkTheme => ThemeData.dark().copyWith(
//       appBarTheme: AppBarTheme().copyWith(
//         backgroundColor: kBackgroundDarkColor,
//       ),
//       cardTheme: CardTheme().copyWith(
//         color: kAccentDarkColor,
//       ),
//     );

// Light Theme
get light => ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color.fromRGBO(57, 90, 198, 1), // background-50
      scaffoldBackgroundColor:
          const Color.fromRGBO(237, 239, 248, 1), // background-50
      textTheme: const TextTheme(
        headlineSmall:
            TextStyle(color: Color.fromRGBO(18, 23, 33, 1)), // text-900
        headlineMedium:
            TextStyle(color: Color.fromRGBO(88, 117, 167, 1)), // text-500
        bodyMedium: TextStyle(color: Color.fromRGBO(35, 47, 67, 1)), // text-800
      ),
      colorScheme: const ColorScheme.light(
        primary: Color.fromRGBO(57, 90, 198, 1), // primary-500
        secondary: Color.fromRGBO(43, 83, 212, 1), // secondary-500
        surface: Color.fromRGBO(182, 192, 226, 1), // background-50
        onPrimary: Color.fromRGBO(235, 239, 249, 1), // primary-50
        onSecondary: Color.fromRGBO(234, 238, 251, 1), // secondary-50
      )
          .copyWith(secondary: const Color.fromRGBO(29, 75, 226, 1))
          .copyWith(background: const Color.fromRGBO(237, 239, 248, 1)),
    );

// Dark Theme
get dark => ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color.fromRGBO(57, 90, 198, 1), // accent-500
      scaffoldBackgroundColor:
          const Color.fromRGBO(7, 10, 18, 1), // background-50
      textTheme: const TextTheme(
        headlineLarge:
            TextStyle(color: Color.fromRGBO(238, 241, 246, 1)), // text-950
        headlineMedium:
            TextStyle(color: Color.fromRGBO(188, 200, 220, 1)), // text-800
        bodyMedium:
            TextStyle(color: Color.fromRGBO(222, 227, 237, 1)), // text-900
      ),
      colorScheme: const ColorScheme.dark(
        primary: Color.fromRGBO(57, 90, 198, 1), // primary-500
        secondary: Color.fromRGBO(43, 83, 212, 1), // secondary-500
        surface: Color.fromRGBO(29, 39, 73, 1), // background-50
        onPrimary: Color.fromRGBO(235, 239, 249, 1), // primary-50
        onSecondary: Color.fromRGBO(234, 238, 251, 1), // secondary-50
      ).copyWith(secondary: const Color.fromRGBO(29, 75, 226, 1)),
    );
