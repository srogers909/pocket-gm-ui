import 'package:flutter/material.dart';

class AppColors {
  // Big Machine Color Palette
  static const Color bigMachine1 = Color(0xFFBD2A2E); // Red - Primary
  static const Color bigMachine2 = Color(0xFF3B3936); // Dark Gray - Background
  static const Color bigMachine3 = Color(0xFFB2BEBF); // Light Gray
  static const Color bigMachine4 = Color(0xFF889C9B); // Medium Gray
  static const Color bigMachine5 = Color(0xFF486966); // Teal - Secondary

  // Midnight Theme Palette (new high-contrast scheme)
  static const Color midnightBackground = Color(0xFF011627); // Deep midnight blue
  static const Color midnightSurface = Color(0xFF02203C); // Slightly lighter panel
  static const Color midnightPrimaryYellow = Color(0xFFFFC700); // Action / link yellow
  static const Color midnightAccent = Color(0xFFFFD84D); // Lighter accent / hover
  static const Color midnightSecondary = Color(0xFF8A9FB1); // Muted slate for secondary UI
  static const Color link = midnightPrimaryYellow; // Explicit semantic link color

  // Color aliases for semantic usage (now pointing to Midnight palette)
  static const Color primary = midnightPrimaryYellow;
  static const Color background = midnightBackground;
  static const Color surface = midnightSurface;
  static const Color onSurface = Colors.white;
  static const Color secondary = midnightSecondary;
  
  // Text colors (adjusted for contrast)
  static const Color onPrimary = Colors.black; // Yellow needs dark text for contrast
  static const Color onBackground = Colors.white;
  static const Color onSecondary = Colors.black;
  
  // Team tier colors for rating display (unchanged)
  static const Color tierSuperBowlContender = Color(0xFF00FF00); // Bright Green
  static const Color tierPlayoffTeam = Color(0xFFADFF2F); // Green-Yellow
  static const Color tierAverage = Color(0xFFFFFF00); // Yellow
  static const Color tierRebuilding = Color(0xFFFFA500); // Orange
  static const Color tierBad = Color(0xFFFF0000); // Bright Red
  static const Color tierUnknown = Color(0xFFFFFFFF); // White for unknown
}
