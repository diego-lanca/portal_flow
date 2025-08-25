import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Definição das cores base
  static const Color bluePrimary = Color(0xFF164194);
  static const Color blueLight = Color(0xFF008BD2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grayLight = Color(0xFFEFEFEF);
  static const Color grayDark = Color(0xFF333333);

  // Light ColorScheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: bluePrimary,
    onPrimary: white,
    secondary: blueLight,
    onSecondary: white,
    error: Colors.red,
    onError: white,
    surface: white,
    onSurface: grayDark,
    outline: grayLight,
  );

  // Dark ColorScheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: bluePrimary,
    onPrimary: white,
    secondary: blueLight,
    onSecondary: white,
    error: Colors.red,
    onError: white,
    surface: grayDark,
    onSurface: white,
    outline: grayLight,
  );

  // Tema claro
  static ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montsserat',
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: lightColorScheme.surface,
    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      foregroundColor: grayDark,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: grayLight,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: bluePrimary,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: bluePrimary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.black.withValues(alpha: 0.15),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: white,
      selectedItemColor: bluePrimary,
      unselectedItemColor: grayDark,
      type: BottomNavigationBarType.fixed,
    ),
  );

  // Tema escuro
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montsserat',
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: darkColorScheme.surface,
    appBarTheme: const AppBarTheme(
      backgroundColor: grayDark,
      foregroundColor: white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: grayLight.withValues(alpha: 0.1),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: bluePrimary,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: blueLight,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: grayDark,
      selectedItemColor: blueLight,
      unselectedItemColor: white,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
