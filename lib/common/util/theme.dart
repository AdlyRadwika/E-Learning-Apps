import 'package:flutter/material.dart';

class ThemeUtil {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50))),
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xff1260a4),
      secondary: const Color(0xff545f70),
      background: const Color(0xfffdfcff),
      tertiary: const Color(0xff6c5677),
      error: const Color(0xffba1a1a),
      outline: const Color(0xff73777f),
      onBackground: const Color(0xff1a1c1e),
      onPrimary: const Color(0xffffffff),
      onSecondary: const Color(0xffffffff),
      onTertiary: const Color(0xffffffff),
      onError: const Color(0xffffffff),
      primaryContainer: const Color(0xffd3e4ff),
      secondaryContainer: const Color(0xffd7e3f8),
      tertiaryContainer: const Color(0xfff4d9ff),
      errorContainer: const Color(0xffffdad6),
      surface: const Color(0xfffdfcff),
      surfaceVariant: const Color(0xffdfe2eb),
      onPrimaryContainer: const Color(0xff001c38),
      onSecondaryContainer: const Color(0xff101c2b),
      onTertiaryContainer: const Color(0xff261431),
      onErrorContainer: const Color(0xff410002),
      onSurface: const Color(0xff1a1c1e),
      onSurfaceVariant: const Color(0xff43474e),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50))),
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: const Color(0xffa1c9ff),
      secondary: const Color(0xffbbc7db),
      background: const Color(0xff1a1c1e),
      tertiary: const Color(0xffd8bde3),
      error: const Color(0xffffb4ab),
      outline: const Color(0xff8d9199),
      onBackground: const Color(0xffe3e2e6),
      onPrimary: const Color(0xff00315b),
      onSecondary: const Color(0xff263141),
      onTertiary: const Color(0xff3c2947),
      onError: const Color(0xff690005),
      primaryContainer: const Color(0xff004880),
      secondaryContainer: const Color(0xff3c4858),
      tertiaryContainer: const Color(0xff533f5f),
      errorContainer: const Color(0xff93000a),
      surface: const Color(0xff1a1c1e),
      surfaceVariant: const Color(0xff43474e),
      onPrimaryContainer: const Color(0xffd3e4ff),
      onSecondaryContainer: const Color(0xffd7e3f8),
      onTertiaryContainer: const Color(0xfff4d9ff),
      onErrorContainer: const Color(0xffffdad6),
      onSurface: const Color(0xffe3e2e6),
      onSurfaceVariant: const Color(0xffc3c6cf),
    ),
  );
}
