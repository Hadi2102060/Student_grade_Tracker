// lib/theme/app_theme.dart

import 'package:flutter/material.dart';

class GradeColors extends ThemeExtension<GradeColors> {
  final Color? a;
  final Color? b;
  final Color? c;
  final Color? f;

  const GradeColors({this.a, this.b, this.c, this.f});

  @override
  GradeColors copyWith({Color? a, Color? b, Color? c, Color? f}) {
    return GradeColors(
      a: a ?? this.a,
      b: b ?? this.b,
      c: c ?? this.c,
      f: f ?? this.f,
    );
  }

  @override
  GradeColors lerp(ThemeExtension<GradeColors>? other, double t) {
    if (other is! GradeColors) return this;
    return GradeColors(
      a: Color.lerp(a, other.a, t),
      b: Color.lerp(b, other.b, t),
      c: Color.lerp(c, other.c, t),
      f: Color.lerp(f, other.f, t),
    );
  }
}

class AppTheme {
  // Light Theme (Requirement: custom ThemeData, no default)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue[700],
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blue,
      surface: Colors.white,
      background: Colors.grey,
      error: Colors.red,
    ),
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue[700],
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16),
    ),
    extensions: const <ThemeExtension<dynamic>>[
      GradeColors(
        a: Color(0xFF2E7D32), // green
        b: Color(0xFF1565C0), // blue
        c: Color(0xFFF57C00), // orange
        f: Color(0xFFD32F2F), // red
      ),
    ],
  );

  // Dark Theme (Requirement: custom ThemeData, no default)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue[300],
    colorScheme: const ColorScheme.dark(
      primary: Colors.blue,
      secondary: Colors.blue,
      surface: Color(0xFF1E1E1E),
      background: Color(0xFF121212),
      error: Colors.red,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue[800],
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2C2C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16),
    ),
    extensions: const <ThemeExtension<dynamic>>[
      GradeColors(
        a: Color(0xFF66BB6A), // lighter green
        b: Color(0xFF64B5F6), // lighter blue
        c: Color(0xFFFFB74D), // lighter orange
        f: Color(0xFFEF9A9A), // lighter red
      ),
    ],
  );
}
