import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  static const String _localeKey = 'selected_locale';
  
  Locale _locale = const Locale('en'); // Default to English
  
  Locale get locale => _locale;
  
  /// Initialize the provider by loading the saved locale from SharedPreferences
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocaleCode = prefs.getString(_localeKey);
    
    if (savedLocaleCode != null) {
      _locale = Locale(savedLocaleCode);
      notifyListeners();
    }
  }
  
  /// Set a new locale and save it to SharedPreferences
  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    
    _locale = locale;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }
  
  /// Get list of supported locales with their display names
  List<LocaleDisplayInfo> get supportedLocales => [
    LocaleDisplayInfo(const Locale('en'), 'English'),
    LocaleDisplayInfo(const Locale('es'), 'Español'),
    LocaleDisplayInfo(const Locale('fr'), 'Français'),
    LocaleDisplayInfo(const Locale('de'), 'Deutsch'),
  ];
}

class LocaleDisplayInfo {
  final Locale locale;
  final String displayName;
  
  const LocaleDisplayInfo(this.locale, this.displayName);
}
