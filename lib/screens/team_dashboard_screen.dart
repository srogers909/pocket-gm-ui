import 'package:flutter/material.dart';
import 'package:pocket_gm_generator/pocket_gm_generator.dart';
import 'package:pocket_gm_widgets/pocket_gm_widgets.dart';
import '../widgets/dashboard_card.dart';

/// TeamDashboardScreen
/// Reduced to a blank placeholder per request. Only retains the [Team] parameter
/// for future expansion without changing call sites.
class TeamDashboardScreen extends StatelessWidget {
  final Team team; // retained for future use

  const TeamDashboardScreen({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    // Minimal header with team name and full-width divider.
    final standingText = '${team.wins}-${team.losses}';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text(
            team.name,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          const Divider(thickness: 1),
          const SizedBox(height: 16),
          Center(
            child: Text(
              standingText,
              textAlign: TextAlign.center,
              style: (Theme.of(context).textTheme.displaySmall ??
                      const TextStyle(fontSize: 42))
                  .copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              // Use portrait layout for screens narrower than 600px
              final isPortrait = constraints.maxWidth < 600;
              
              // Create Team Stats card
              final teamStatsCard = DashboardCard(
                title: 'Team Stats',
                child: Text(
                  'Coming soon...',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white70),
                ),
              );

              // Create Team Leaders card
              final teamLeadersCard = DashboardCard(
                title: 'Team Leaders',
                initiallyExpanded: true,
                child: Builder(
                  builder: (context) {
                    // Prepare top players (top 5 by overall rating)
                    final roster = team.roster;
                    final sorted = [...roster]..sort((a, b) => b.overallRating.compareTo(a.overallRating));
                    final display = sorted.take(5).toList();

                    int? extractAge(String birthInfo) {
                      final match = RegExp(r'\\((\\d+)\\s*yrs?\\)').firstMatch(birthInfo);
                      if (match != null) {
                        return int.tryParse(match.group(1)!);
                      }
                      return null;
                    }

                    final columns = <DataGridColumn<Player>>[
                      DataGridColumn<Player>(
                        title: 'Name',
                        width: 140.0, // Fixed width for player names to ensure they have enough space
                        cellBuilder: (ctx, p) => Text(p.commonName),
                        sortValue: (p) => p.commonName.toLowerCase(),
                      ),
                      DataGridColumn<Player>(
                        title: 'Pos',
                        width: 50.0, // Fixed width for position abbreviations
                        cellBuilder: (ctx, p) => Text(p.primaryPosition),
                        sortValue: (p) => p.primaryPosition,
                        alignment: Alignment.center,
                      ),
                      DataGridColumn<Player>(
                        title: 'Age',
                        width: 50.0, // Fixed width for age numbers
                        cellBuilder: (ctx, p) {
                          final age = extractAge(p.birthInfo);
                          return Text(age != null ? age.toString() : '-');
                        },
                        sortValue: (p) => extractAge(p.birthInfo) ?? -1,
                        alignment: Alignment.center,
                        numeric: true,
                      ),
                      DataGridColumn<Player>(
                        title: 'OVR',
                        width: 50.0, // Fixed width for overall rating numbers
                        cellBuilder: (ctx, p) => Text(p.overallRating.toString()),
                        sortValue: (p) => p.overallRating,
                        alignment: Alignment.center,
                        numeric: true,
                      ),
                      DataGridColumn<Player>(
                        title: 'GP',
                        flex: 1, // Use remaining space for games played
                        cellBuilder: (ctx, p) => const Text('-'), // Placeholder until season stats exist
                        // No sortValue yet (not sortable)
                        alignment: Alignment.center,
                      ),
                    ];

                    return SizedBox(
                      height: 260,
                      child: DataGrid<Player>(
                        data: display,
                        columns: columns,
                        initialSortColumnIndex: 3, // OVR
                        initialAscending: false,
                        cellPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        rowMinHeight: 35,
                        emptyPlaceholder: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'No players',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white70),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );

              if (isPortrait) {
                // Portrait layout: Team Stats first, then Team Leaders below, both full width
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    teamStatsCard,
                    const SizedBox(height: 16),
                    teamLeadersCard,
                  ],
                );
              } else {
                // Landscape layout: Side by side
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: teamLeadersCard),
                    Expanded(child: teamStatsCard),
                  ],
                );
              }
            },
          ),
          ],
        ),
      ),
    );
  }
}
