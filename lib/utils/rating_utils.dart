import 'package:flutter/material.dart';

/// Utility class for converting numerical ratings to letter grades and colors
class RatingUtils {
  /// Converts a numerical rating (0-100) to a letter grade
  static String getLetterGrade(int rating) {
    if (rating >= 97) return 'A+';
    if (rating >= 93) return 'A';
    if (rating >= 90) return 'A-';
    if (rating >= 87) return 'B+';
    if (rating >= 83) return 'B';
    if (rating >= 80) return 'B-';
    if (rating >= 77) return 'C+';
    if (rating >= 73) return 'C';
    if (rating >= 70) return 'C-';
    if (rating >= 67) return 'D+';
    if (rating >= 63) return 'D';
    if (rating >= 60) return 'D-';
    return 'F';
  }

  /// Returns a color with distinct variations for each letter grade tier
  static Color getRatingColor(int rating) {
    // Clamp rating to 0-100 range
    final clampedRating = rating.clamp(0, 100);
    
    // Return distinct colors for each letter grade tier
    if (clampedRating >= 90) {
      return const Color(0xFF00C853); // A Grade - Vibrant Green
    } else if (clampedRating >= 80) {
      return const Color(0xFF64DD17); // B Grade - Light Green
    } else if (clampedRating >= 70) {
      return const Color(0xFFFFD600); // C Grade - Yellow
    } else if (clampedRating >= 60) {
      return const Color(0xFFFF9100); // D Grade - Orange
    } else {
      return const Color(0xFFD50000); // F Grade - Red
    }
  }

  /// Returns a background color for rating chips based on the main color
  static Color getRatingBackgroundColor(int rating) {
    final mainColor = getRatingColor(rating);
    return mainColor.withValues(alpha: 0.15);
  }

  /// Returns a border color for rating chips based on the main color
  static Color getRatingBorderColor(int rating) {
    final mainColor = getRatingColor(rating);
    return mainColor.withValues(alpha: 0.8);
  }

  /// Returns true if the text should be white for better contrast
  static bool shouldUseWhiteText(int rating) {
    // Use white text for darker colors (lower ratings)
    return rating < 70;
  }

  /// Gets the text color for rating display
  static Color getRatingTextColor(int rating) {
    return shouldUseWhiteText(rating) ? Colors.white : Colors.black87;
  }
}
