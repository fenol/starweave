import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Всі кольори і шрифти гри в одному місці
class AppTheme {
  
  // ── Кольори ──────────────────────────────────────
  static const Color background      = Color(0xFF0A0E1A); // Глибокий космос
  static const Color skyColor        = Color(0xFF0D1B3E); // Темна ніч
  static const Color starInactive    = Color(0xFFC8D8F0); // Зірка звичайна
  static const Color starActive      = Color(0xFFF0E8C8); // Зірка знайдена
  static const Color constellationLine = Color(0xFF7EB8D4); // Лінія сузір'я
  static const Color accent          = Color(0xFFD4A96A); // Підказки
  static const Color textPrimary     = Color(0xFFEAE6DC); // Основний текст
  static const Color textSecondary   = Color(0xFF7A8FA6); // Другорядний текст

  // ── Шрифти ───────────────────────────────────────

  // Для назви гри і заголовків
  static TextStyle titleStyle = GoogleFonts.cormorantGaramond(
    fontWeight: FontWeight.w300,
    color: textPrimary,
    letterSpacing: 8.0,
    fontSize: 32,
  );

  // Для назв сезонів і секцій
  static TextStyle labelStyle = GoogleFonts.josefinSans(
    fontWeight: FontWeight.w100,
    color: textPrimary,
    letterSpacing: 4.0,
    fontSize: 14,
  );

  // Для описів і підказок
  static TextStyle bodyStyle = GoogleFonts.raleway(
    fontWeight: FontWeight.w300,
    color: textSecondary,
    fontSize: 14,
  );

  // Для кнопок
  static TextStyle buttonStyle = GoogleFonts.quicksand(
    fontWeight: FontWeight.w400,
    color: textPrimary,
    fontSize: 16,
  );

  // Загальна тема додатку
  static ThemeData get theme => ThemeData(
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(
      primary: starActive,
      secondary: constellationLine,
      surface: skyColor,
    ),
  );
}