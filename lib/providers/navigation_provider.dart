import 'package:flutter/foundation.dart';

/// Enum representing the top-level logical pages shown inside the persistent
/// main scaffold body (under a fixed, never-replaced AppBar).
enum AppPage {
  cover,
  dashboard,
}

/// NavigationProvider
/// Holds the currently active [AppPage] for in-place body swapping so that
/// we never push new MaterialPageRoutes (which would introduce a back button
/// and different AppBars). The AppBar stays constant; only the body changes.
class NavigationProvider extends ChangeNotifier {
  AppPage _current = AppPage.cover;

  AppPage get current => _current;

  String get currentTitle {
    switch (_current) {
      case AppPage.cover:
        return 'Pocket GM';
      case AppPage.dashboard:
        return 'Dashboard';
    }
  }

  void setPage(AppPage page) {
    if (page == _current) return;
    _current = page;
    notifyListeners();
  }
}
