import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/settings_drawer.dart';
import '../providers/team_provider.dart';
import '../providers/navigation_provider.dart';
import '../screens/cover_page.dart';
import 'team_dashboard_screen.dart';

class MainScaffold extends StatefulWidget {
  final Widget? body;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const MainScaffold({
    super.key,
    this.body,
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Consumer<NavigationProvider>(
          builder: (context, nav, _) {
            return MainAppBar(
              onMenuPressed: _openDrawer,
              onSettingsPressed: _openEndDrawer,
              title: nav.currentTitle,
            );
          },
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Text(
                  'Navigation',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.swap_horiz),
                title: const Text('Switch League'),
                onTap: () {
                  // Placeholder: navigation to league switcher coming soon.
                  // Intentionally left empty per requirement.
                },
              ),
              Consumer<TeamProvider>(
                builder: (context, teamProvider, _) {
                  final hasTeam = teamProvider.hasTeam;
                  return ListTile(
                    leading: const Icon(Icons.dashboard),
                    title: const Text('Dashboard'),
                    enabled: hasTeam,
                    onTap: hasTeam
                        ? () {
                            Navigator.of(context).pop(); // close drawer
                            context.read<NavigationProvider>().setPage(AppPage.dashboard);
                          }
                        : null,
                  );
                },
              ),
              const Divider(),
              const Expanded(
                child: Center(
                  child: Text(
                    'More Coming Soon',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: const SettingsDrawer(),
      body: widget.body ??
          Consumer<NavigationProvider>(
            builder: (context, nav, _) {
              switch (nav.current) {
                case AppPage.cover:
                  return const CoverPage();
                case AppPage.dashboard:
                  final teamProv = context.watch<TeamProvider>();
                  if (!teamProv.hasTeam) {
                    return const Center(
                      child: Text(
                        'Select a team to view dashboard',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return TeamDashboardScreen(team: teamProv.selectedTeam!);
              }
            },
          ),
    );
  }
}
