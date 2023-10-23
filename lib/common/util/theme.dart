import 'package:flutter/material.dart';

var themeData = ThemeData(
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50))),
      
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      background: const Color.fromARGB(255, 244, 247, 255),
    ));
