import 'package:flutter/foundation.dart';
import 'package:pocket_gm_generator/pocket_gm_generator.dart';

/// TeamProvider
/// Holds the currently selected [Team] so that any part of the UI (e.g. drawer)
/// can react (e.g. enable a Dashboard navigation link).
class TeamProvider extends ChangeNotifier {
  Team? _selectedTeam;

  Team? get selectedTeam => _selectedTeam;
  bool get hasTeam => _selectedTeam != null;

  void setTeam(Team team) {
    _selectedTeam = team;
    notifyListeners();
  }

  void clearTeam() {
    _selectedTeam = null;
    notifyListeners();
  }
}
