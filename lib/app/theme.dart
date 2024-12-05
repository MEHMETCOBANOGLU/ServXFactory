import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  ThemeData get theme => themeMode == ThemeMode.light ? lightTheme : darkTheme;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  static ThemeData get lightTheme => ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF3b368c),
          secondary: Color(0xFFf17907), //f17907
          tertiary: Color(0xFFFDF6EF),
          surface: Color(0xFF262554), //6358f6
          onPrimary: Color.fromARGB(255, 89, 88, 155), //6358f6
          // surface: Color(0xFF3b368c),
          // onSurface: Color(0xFF414A4C),
          onSurface: Colors.white,
          error: Color(0xFFf17907),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xFF3b368c),
          ),
        ),
        //set the show snackbar theme
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFFf17907),
          contentTextStyle: TextStyle(color: Colors.white),
          actionTextColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFF414A4C),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF97C3E9),
          secondary: Color(0xFF778899),
          surface: Color(0xFF414A4C),
          onSurface: Colors.white,
          error: Color(0xFF414A4C),
          tertiary: Color(0xFFB5C4C7),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xFF97C3E9),
          ),
        ),
      );
}
