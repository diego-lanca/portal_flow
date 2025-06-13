import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Light Theme ColorScheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF006973),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF9EEFFC),
    onPrimaryContainer: Color(0xFF001F23),
    secondary: Color(0xFF466368),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFC9E8ED),
    onSecondaryContainer: Color(0xFF001F23),
    tertiary: Color(0xFF715189),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFF2DAFF),
    onTertiaryContainer: Color(0xFF2A0C41),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: Color(0xFFEDF8FA),
    onSurface: Color(0xFF1C1B1B),
    surfaceContainerHighest: Color(0xFFE5E2E1),
    onSurfaceVariant: Color(0xFF434849),
    outline: Color(0xFF747879),
    outlineVariant: Color(0xFFC3C7C8),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF313030),
    onInverseSurface: Color(0xFFF3F0EF),
    inversePrimary: Color(0xFF82D3DF),
    surfaceTint: Color(0xFF5B5F60),
    surfaceDim: Color(0xFFDCD9D9),
    surfaceBright: Color(0xFFFCF8F8),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF6F3F2),
    surfaceContainer: Color(0xFFF0EDEC),
    surfaceContainerHigh: Color(0xFFEBE7E7),
  );

  // Dark Theme ColorScheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF82D3DF),
    onPrimary: Color(0xFF00363C),
    primaryContainer: Color(0xFF004F57),
    onPrimaryContainer: Color(0xFF9EEFFC),
    secondary: Color(0xFFADCCD1),
    onSecondary: Color(0xFF173539),
    secondaryContainer: Color(0xFF2E4B50),
    onSecondaryContainer: Color(0xFFC9E8ED),
    tertiary: Color(0xFFDEB8F7),
    onTertiary: Color(0xFF412357),
    tertiaryContainer: Color(0xFF583A6F),
    onTertiaryContainer: Color(0xFFF2DAFF),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF121212),
    onSurface: Color(0xFFE5E2E1),
    surfaceContainerHighest: Color(0xFF353534),
    onSurfaceVariant: Color(0xFFC3C7C8),
    outline: Color(0xFF8E9192),
    outlineVariant: Color(0xFF434849),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFE5E2E1),
    onInverseSurface: Color(0xFF313030),
    inversePrimary: Color(0xFF006973),
    surfaceTint: Color(0xFFC4C7C8),
    surfaceDim: Color(0xFF131313),
    surfaceBright: Color(0xFF3A3939),
    surfaceContainerLowest: Color(0xFF0E0E0E),
    surfaceContainerLow: Color(0xFF1C1B1B),
    surfaceContainer: Color(0xFF1A1A1A),
    surfaceContainerHigh: Color(0xFF2A2A2A),
  );

  // Cores customizadas extras (para usar quando necessário)
  static const Color lightSurfaceDim = Color(0xFFDCD9D9);
  static const Color lightSurfaceBright = Color(0xFFFCF8F8);
  static const Color lightSurfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainerLow = Color(0xFFF6F3F2);
  static const Color lightSurfaceContainer = Color(0xFFF0EDEC);
  static const Color lightSurfaceContainerHigh = Color(0xFFEBE7E7);
  static const Color lightSurfaceVariant = Color(0xFFDFE3E4);

  static const Color darkSurfaceDim = Color(0xFF131313);
  static const Color darkSurfaceBright = Color(0xFF3A3939);
  static const Color darkSurfaceContainerLowest = Color(0xFF0E0E0E);
  static const Color darkSurfaceContainerLow = Color(0xFF1C1B1B);
  static const Color darkSurfaceContainer = Color(0xFF201F1F);
  static const Color darkSurfaceContainerHigh = Color(0xFF2A2A2A);
  static const Color darkSurfaceVariant = Color(0xFF434849);

  // Light Theme
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: lightColorScheme.surface,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.surface,
      foregroundColor: lightColorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: lightSurfaceContainer,
      elevation: 1,
      shadowColor: lightColorScheme.shadow.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        elevation: 1,
        shadowColor: lightColorScheme.shadow.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: lightColorScheme.primary,
        side: BorderSide(color: lightColorScheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: lightColorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurfaceContainerHigh,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: BorderSide(color: lightColorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: BorderSide(color: lightColorScheme.outline, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: BorderSide(color: lightColorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: BorderSide(color: lightColorScheme.error),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightColorScheme.primaryContainer,
      foregroundColor: lightColorScheme.onPrimaryContainer,
      elevation: 3,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightColorScheme.surface,
      selectedItemColor: lightColorScheme.primary,
      unselectedItemColor: lightColorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: lightColorScheme.outlineVariant,
      thickness: 1,
    ),
  );

  // Dark Theme
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: darkColorScheme.surface,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: darkColorScheme.surface,
      foregroundColor: darkColorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: darkSurfaceContainer,
      elevation: 1,
      shadowColor: darkColorScheme.shadow.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
        elevation: 1,
        shadowColor: darkColorScheme.shadow.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: darkColorScheme.primary,
        side: BorderSide(color: darkColorScheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: darkColorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurfaceContainerHigh,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: BorderSide(color: darkColorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: BorderSide(color: darkColorScheme.outline, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: BorderSide(color: darkColorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: BorderSide(color: darkColorScheme.error),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkColorScheme.primaryContainer,
      foregroundColor: darkColorScheme.onPrimaryContainer,
      elevation: 3,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkColorScheme.surface,
      selectedItemColor: darkColorScheme.primary,
      unselectedItemColor: darkColorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: darkColorScheme.outlineVariant,
      thickness: 1,
    ),
  );
}
