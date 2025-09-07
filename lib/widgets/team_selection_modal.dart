import 'package:flutter/material.dart';
import 'package:pocket_gm_generator/pocket_gm_generator.dart';
import '../generated/app_localizations.dart';
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
        return AppColors.tierSuperBowlContender;
      case TeamTier.playoffTeam:
        return AppColors.tierPlayoffTeam;
      case TeamTier.average:
        return AppColors.tierAverage;
      case TeamTier.rebuilding:
        return AppColors.tierRebuilding;
      case TeamTier.bad:
        return AppColors.tierBad;
      default:
        return AppColors.tierUnknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: Text(
        localizations.chooseYourTeam,
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
                final Color conferenceColor = conference.name == 'LFC' 
                    ? const Color(0xFF616161) // Medium gray for LFC
                    : const Color(0xFF424242); // Darker gray for FFC

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
                      localizations.ratingKey,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.background,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...TeamTier.values.map((tier) {
                      String tierName;
                      String ratingRange;
                      switch (tier) {
                        case TeamTier.superBowlContender:
                          tierName = localizations.tierElite;
                          ratingRange = '85+';
                          break;
                        case TeamTier.playoffTeam:
                          tierName = localizations.tierStrong;
                          ratingRange = '80-84';
                          break;
                        case TeamTier.average:
                          tierName = localizations.tierAverage;
                          ratingRange = '76-79';
                          break;
                        case TeamTier.rebuilding:
                          tierName = localizations.tierRebuilding;
                          ratingRange = '71-75';
                          break;
                        case TeamTier.bad:
                          tierName = localizations.tierPoor;
                          ratingRange = '66-70';
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
                              '$ratingRange ($tierName)',
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
