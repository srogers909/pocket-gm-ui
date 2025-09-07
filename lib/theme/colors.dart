import 'package:flutter/material.dart';

class AppColors {
  // Big Machine Color Palette
  static const Color bigMachine1 = Color(0xFFBD2A2E); // Red - Primary
  static const Color bigMachine2 = Color(0xFF3B3936); // Dark Gray - Background
  static const Color bigMachine3 = Color(0xFFB2BEBF); // Light Gray
  static const Color bigMachine4 = Color(0xFF889C9B); // Medium Gray
  static const Color bigMachine5 = Color(0xFF486966); // Teal - Secondary

  // Color aliases for semantic usage
  static const Color primary = bigMachine1;
  static const Color background = bigMachine2;
  static const Color surface = bigMachine3;
  static const Color onSurface = bigMachine4;
  static const Color secondary = bigMachine5;
  
  // Text colors
  static const Color onPrimary = Colors.white;
  static const Color onBackground = bigMachine3;
  static const Color onSecondary = Colors.white;
  
  // Team tier colors for rating display
  static const Color tierSuperBowlContender = Color(0xFF00FF00); // Bright Green
  static const Color tierPlayoffTeam = Color(0xFFADFF2F); // Green-Yellow
  static const Color tierAverage = Color(0xFFFFFF00); // Yellow
  static const Color tierRebuilding = Color(0xFFFFA500); // Orange
  static const Color tierBad = Color(0xFFFF0000); // Bright Red
  static const Color tierUnknown = Color(0xFFFFFFFF); // White for unknown
}
