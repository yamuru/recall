import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _seedColor = Color.fromARGB(255, 33, 150, 243);

final _colorScheme = ColorScheme.fromSeed(seedColor: _seedColor);

final _darkColorScheme =
    ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: _seedColor);

class AppTheme {
  static Color systemUIBackgroundAppTopColor = _colorScheme.primary;
  static Color systemUIBackgroundAppBottomColor = _colorScheme.primary;

  static ThemeData get theme {
    return ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: _colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: GoogleFonts.arimoTextTheme(),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: GoogleFonts.arimoTextTheme(
        TextTheme(
          displayLarge: TextStyle(color: _darkColorScheme.onBackground),
          displayMedium: TextStyle(color: _darkColorScheme.onBackground),
          displaySmall: TextStyle(color: _darkColorScheme.onBackground),
          headlineLarge: TextStyle(color: _darkColorScheme.onBackground),
          headlineMedium: TextStyle(color: _darkColorScheme.onBackground),
          headlineSmall: TextStyle(color: _darkColorScheme.onBackground),
          titleLarge: TextStyle(color: _darkColorScheme.onBackground),
          titleMedium: TextStyle(color: _darkColorScheme.onBackground),
          titleSmall: TextStyle(color: _darkColorScheme.onBackground),
          bodyLarge: TextStyle(color: _darkColorScheme.onBackground),
          bodyMedium: TextStyle(color: _darkColorScheme.onBackground),
          bodySmall: TextStyle(color: _darkColorScheme.onBackground),
          labelLarge: TextStyle(color: _darkColorScheme.onBackground),
          labelMedium: TextStyle(color: _darkColorScheme.onBackground),
          labelSmall: TextStyle(color: _darkColorScheme.onBackground),
        ),
      ),
    );
  }
}
