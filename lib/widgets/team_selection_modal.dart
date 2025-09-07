import 'package:flutter/material.dart';
import 'package:pocket_gm_generator/pocket_gm_generator.dart';
import '../theme/colors.dart';

class TeamSelectionModal extends StatelessWidget {
  final League league;
  final Function(Team) onTeamSelected;

  const TeamSelectionModal({
    super.key,
    required this.league,
    required this.onTeamSelected,
  });

  /// Returns the color for a team's overall rating based on their tier
  Color _getTierColor(TeamTier? tier) {
    switch (tier) {
      case TeamTier.superBowlContender:
        return const Color(0xFF00FF00); // Bright Green
      case TeamTier.playoffTeam:
        return const Color(0xFF8BC34A); // Light Green
      case TeamTier.average:
        return const Color(0xFFFFEB3B); // Yellow
      case TeamTier.rebuilding:
        return const Color(0xFFFF9800); // Orange
      case TeamTier.bad:
        return const Color(0xFFF44336); // Red
      default:
        return const Color(0xFFFFFFFF); // White for unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: Text(
        'Choose your team:',
        style: TextStyle(
          color: AppColors.background,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Conference sections
              ...league.conferences.map((conference) {
                // Use neutral gray colors for each conference to avoid clashing with rating colors
                final Color conferenceColor = conference.name == 'AFC' 
                    ? const Color(0xFF616161) // Medium gray for AFC
                    : const Color(0xFF424242); // Darker gray for NFC

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Conference Header
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      child: Text(
                        conference.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                    // Divisions within this conference
                    ...conference.divisions.map((division) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Division Sub-Header
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 4.0),
                            child: Text(
                              division.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.background,
                              ),
                            ),
                          ),
                          // Team Buttons for this division (sorted by overall rating descending)
                          ...(division.teams.toList()
                              ..sort((a, b) => b.averageOverallRating.compareTo(a.averageOverallRating)))
                              .map((team) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    onTeamSelected(team);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: conferenceColor,
                                    foregroundColor: AppColors.onPrimary,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 12.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Left-aligned team name
                                      Expanded(
                                        child: Text(
                                          team.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      // Right-aligned team overall rating
                                      Text(
                                        team.averageOverallRating.toStringAsFixed(1),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: _getTierColor(team.tier),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    }).toList(),
                    const SizedBox(height: 12), // Space between conferences
                  ],
                );
              }).toList(),
              // Rating Key Section
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rating Key:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.background,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...TeamTier.values.map((tier) {
                      String ratingRange;
                      switch (tier) {
                        case TeamTier.superBowlContender:
                          ratingRange = '85+ (Elite)';
                          break;
                        case TeamTier.playoffTeam:
                          ratingRange = '80-84 (Strong)';
                          break;
                        case TeamTier.average:
                          ratingRange = '76-79 (Average)';
                          break;
                        case TeamTier.rebuilding:
                          ratingRange = '71-75 (Rebuilding)';
                          break;
                        case TeamTier.bad:
                          ratingRange = '66-70 (Poor)';
                          break;
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            // Color indicator
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: _getTierColor(tier),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Tier name and rating range
                            Text(
                              '${tier.displayName}: $ratingRange',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.background,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
