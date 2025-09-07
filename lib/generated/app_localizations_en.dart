// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pocket GM';

  @override
  String get newButton => 'New';

  @override
  String get loadButton => 'Load';

  @override
  String get chooseSaveSlot => 'Choose Save Slot';

  @override
  String get chooseSaveSlotToLoad => 'Choose Save Slot to Load';

  @override
  String get empty => 'EMPTY';

  @override
  String get cancel => 'Cancel';

  @override
  String get generationSourceQuestion =>
      'Do you want to generate a league or load an online roster file?';

  @override
  String get loadFromOnline => 'Load from Online';

  @override
  String get generate => 'Generate';

  @override
  String get chooseYourTeam => 'Choose your team:';

  @override
  String get ratingKey => 'Rating Key:';

  @override
  String get tierElite => 'Elite';

  @override
  String get tierStrong => 'Strong';

  @override
  String get tierAverage => 'Average';

  @override
  String get tierRebuilding => 'Rebuilding';

  @override
  String get tierPoor => 'Poor';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';
}
