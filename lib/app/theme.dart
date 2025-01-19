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
        cardColor: Color.fromARGB(255, 241, 240, 255),
        dialogBackgroundColor: const Color.fromARGB(255, 141, 138, 224),
        secondaryHeaderColor: Color.fromARGB(255, 241, 240, 255),

        // Renk paleti ve tema genel renkleri
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF3b368c),
          secondary: Color(0xFFf17907),
          onSecondary: Color.fromARGB(255, 236, 236, 236),
          tertiary: Color.fromARGB(255, 255, 255, 255),
          surface: Color(0xFF262554),
          onPrimary: Color.fromARGB(255, 89, 88, 155),
          // onSurface: Colors.red,
          // onSurface: Colors.white70,
          error: Color(0xFFf17907),
        ),

        // AppBar teması
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF262554),
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          // shadowColor: Color.fromARGB(255, 89, 88, 155),
          toolbarTextStyle: TextStyle(color: Colors.white),
          elevation: 4.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        tabBarTheme: const TabBarTheme(
          dividerColor: Color(0xFF262554),
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Color(0xFFf17907),
          unselectedLabelColor: Colors.white70,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Color(0xFFf17907),
              width: 2.0,
            ),
            insets: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),

        // Button teması
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3b368c),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        ///
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 241, 240, 255),
          selectedItemColor: Color(0xFFf17907),
          unselectedItemColor: Color(0xFF3b368c),
          elevation: 4.0,
          selectedIconTheme: IconThemeData(color: Color(0xFFf17907)),
          unselectedIconTheme: IconThemeData(
            color: Color(0xFF3b368c),
          ),
          selectedLabelStyle: TextStyle(color: Color(0xFFf17907)),
          unselectedLabelStyle: TextStyle(color: Color(0xFF3b368c)),
          type: BottomNavigationBarType.fixed,
        ),

        //

        // TextField teması
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF1F3F6),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF3b368c)),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF3b368c)),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          hintStyle: TextStyle(color: Colors.grey),
        ),

        // Kart teması
        cardTheme: const CardTheme(
          color: Colors.white,
          shadowColor: Colors.grey,
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),

        // Liste Tile teması
        listTileTheme: const ListTileThemeData(
          tileColor: Color.fromARGB(255, 241, 240, 255),
          textColor: Colors.black,
          iconColor: Color(0xFF3b368c),
        ),

        // İkon teması
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xFF3b368c),
          ),
        ),

        // SnackBar teması
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFFf17907),
          contentTextStyle: TextStyle(color: Colors.white),
          actionTextColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),

        // Çip (Chip) teması
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFFf1f3f4),
          selectedColor: const Color(0xFF3b368c),
          secondarySelectedColor: const Color(0xFFf17907),
          labelStyle: const TextStyle(color: Colors.black),
          secondaryLabelStyle: const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFF2C2C2C),

        // Renk paleti ve tema genel renkleri
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF64B5F6),
          secondary: Color(0xFF42A5F5),
          surface: Color(0xFF1E1E1E),
          onSurface: Color(0xFF9E9E9E),
          error: Color(0xFFD32F2F),
          tertiary: Color(0xFFB5C4C7),
        ),

        // AppBar teması
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E88E5),
          foregroundColor: Colors.white,
          elevation: 4.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Button teması
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF64B5F6),
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // TextField teması
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF424242),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF64B5F6)),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF64B5F6)),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          hintStyle: TextStyle(color: Colors.grey),
        ),

        // Kart teması
        cardTheme: const CardTheme(
          color: Color(0xFF2C2C2C),
          shadowColor: Colors.black,
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),

        // Liste Tile teması
        listTileTheme: const ListTileThemeData(
          tileColor: Color(0xFF1E1E1E),
          textColor: Colors.white,
          iconColor: Color(0xFF64B5F6),
        ),

        // İkon teması
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xFF64B5F6),
          ),
        ),

        // SnackBar teması
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFF42A5F5),
          contentTextStyle: TextStyle(color: Colors.black),
          actionTextColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),

        // Çip (Chip) teması
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFF424242),
          selectedColor: const Color(0xFF64B5F6),
          secondarySelectedColor: const Color(0xFF42A5F5),
          labelStyle: const TextStyle(color: Colors.white),
          secondaryLabelStyle: const TextStyle(color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );
}
