// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Pocket GM';

  @override
  String get newButton => 'Nouveau';

  @override
  String get loadButton => 'Charger';

  @override
  String get chooseSaveSlot => 'Choisir l\'Emplacement de Sauvegarde';

  @override
  String get chooseSaveSlotToLoad =>
      'Choisir l\'Emplacement de Sauvegarde à Charger';

  @override
  String get empty => 'VIDE';

  @override
  String get cancel => 'Annuler';

  @override
  String get generationSourceQuestion =>
      'Voulez-vous générer une ligue ou charger un fichier de roster en ligne ?';

  @override
  String get loadFromOnline => 'Charger depuis Internet';

  @override
  String get generate => 'Générer';

  @override
  String get chooseYourTeam => 'Choisissez votre équipe :';

  @override
  String get ratingKey => 'Clé des Évaluations :';

  @override
  String get tierElite => 'Élite';

  @override
  String get tierStrong => 'Fort';

  @override
  String get tierAverage => 'Moyen';

  @override
  String get tierRebuilding => 'Reconstruction';

  @override
  String get tierPoor => 'Faible';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';
}
