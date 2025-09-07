import 'package:flutter/material.dart';
import 'package:pocket_gm_generator/pocket_gm_generator.dart';
import '../widgets/player_list_item.dart';
import '../theme/colors.dart';

class RosterScreen extends StatefulWidget {
  final Team team;

  const RosterScreen({
    super.key,
    required this.team,
  });

  @override
  State<RosterScreen> createState() => _RosterScreenState();
}

class _RosterScreenState extends State<RosterScreen> {
  late Map<String, List<Player>> _playersByPosition;

  @override
  void initState() {
    super.initState();
    _groupPlayersByPosition();
  }

  /// Groups players by their primary position
  void _groupPlayersByPosition() {
    _playersByPosition = <String, List<Player>>{};
    
    for (final player in widget.team.roster) {
      final position = player.primaryPosition;
      _playersByPosition[position] ??= <Player>[];
      _playersByPosition[position]!.add(player);
    }
    
    // Sort players within each position by overall rating (highest first)
    for (final positionPlayers in _playersByPosition.values) {
      positionPlayers.sort((a, b) => b.overallRating.compareTo(a.overallRating));
    }
  }

  /// Returns a user-friendly position group name
  String _getPositionGroupName(String position) {
    switch (position) {
      case 'QB':
        return 'Quarterbacks';
      case 'RB':
        return 'Running Backs';
      case 'WR':
        return 'Wide Receivers';
      case 'TE':
        return 'Tight Ends';
      case 'OL':
        return 'Offensive Line';
      case 'DL':
        return 'Defensive Line';
      case 'LB':
        return 'Linebackers';
      case 'CB':
        return 'Cornerbacks';
      case 'S':
      case 'FS':
      case 'SS':
        return 'Safeties';
      case 'K':
        return 'Kickers';
      default:
        return '${position}s';
    }
  }

  /// Gets the display order for position groups
  List<String> _getPositionOrder() {
    final List<String> order = [
      'QB',
      'RB', 
      'WR',
      'TE',
      'OL',
      'DL',
      'LB',
      'CB',
      'S',
      'FS', 
      'SS',
      'K'
    ];
    
    // Add any other positions that might exist
    final Set<String> existingPositions = _playersByPosition.keys.toSet();
    final Set<String> orderedPositions = order.toSet();
    final List<String> otherPositions = existingPositions.difference(orderedPositions).toList();
    otherPositions.sort();
    
    return [...order.where((pos) => _playersByPosition.containsKey(pos)), ...otherPositions];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        title: Text(
          '${widget.team.name} Roster',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Team info header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.team.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Division: ${widget.team.division}',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.background.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Overall Rating: ${widget.team.averageOverallRating.ceil()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.background.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Roster Size: ${widget.team.roster.length} players',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.background.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Roster list
            Expanded(
              child: ListView.builder(
                itemCount: _getPositionOrder().length,
                itemBuilder: (context, index) {
                  final position = _getPositionOrder()[index];
                  final players = _playersByPosition[position]!;
                  
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Position group header
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          '${_getPositionGroupName(position)} (${players.length})',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      // Players in this position
                      ...players.map((player) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: PlayerListItem(player: player),
                      )),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
