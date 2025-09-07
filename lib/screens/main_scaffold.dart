import 'package:flutter/material.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/settings_drawer.dart';

class MainScaffold extends StatefulWidget {
  final Widget body;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const MainScaffold({
    super.key,
    required this.body,
    this.scaffoldKey,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = widget.scaffoldKey ?? GlobalKey<ScaffoldState>();
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        onMenuPressed: _openDrawer,
        onSettingsPressed: _openEndDrawer,
      ),
      drawer: const Drawer(
        child: Center(
          child: Text(
            'Menu\n(Coming Soon)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      endDrawer: const SettingsDrawer(),
      body: widget.body,
    );
  }
}
