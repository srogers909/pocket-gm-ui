import 'package:flutter/material.dart';
import 'package:pocket_gm_generator/pocket_gm_generator.dart';
import '../generated/app_localizations.dart';
import '../theme/colors.dart';
import '../utils/rating_utils.dart';

class TeamSelectionModal extends StatefulWidget {
  final League league;
  final Function(Team) onTeamSelected;

  const TeamSelectionModal({
    super.key,
    required this.league,
    required this.onTeamSelected,
  });

  @override
  State<TeamSelectionModal> createState() => _TeamSelectionModalState();
}

class _TeamSelectionModalState extends State<TeamSelectionModal> {
  bool _showOverallRating = false;


  /// Shows a confirmation dialog when a team is selected
  void _showTeamConfirmationDialog(Team team) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Are you sure you want to control ${team.name}?',
            style: TextStyle(
              color: AppColors.background,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close confirmation dialog
                    Navigator.of(context).pop(); // Close team selection modal
                    widget.onTeamSelected(team);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text(
                    'Yes!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close confirmation dialog only
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade600,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
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
              // Show overall rating toggle
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Show overall rating',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.background,
                      ),
                    ),
                    Switch(
                      value: _showOverallRating,
                      onChanged: (bool value) {
                        setState(() {
                          _showOverallRating = value;
                        });
                      },
                      activeThumbColor: AppColors.primary,
                      inactiveTrackColor: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
              // Conference sections
              ...widget.league.conferences.map((conference) {
                // Use neutral gray colors for each conference to avoid clashing with rating colors
                final Color conferenceColor = conference.abbreviation == 'LFC' 
                    ? const Color(0xFF616161) // Medium gray for LFC
                    : const Color(0xFF424242); // Darker gray for FFC

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Conference Header
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      child: Text(
                        '${conference.name} (${conference.abbreviation})',
                        style: TextStyle(
                          fontSize: 16,
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
                          ...(division.teams
                              ..sort((a, b) => b.averageOverallRating.compareTo(a.averageOverallRating)))
                              .map((team) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showTeamConfirmationDialog(team);
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
                                      // Right-aligned team overall rating (conditional)
                                      if (_showOverallRating)
                                        Text(
                                          RatingUtils.getLetterGrade(team.averageOverallRating.ceil()),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: RatingUtils.getRatingColor(team.averageOverallRating.ceil()),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    }),
                    const SizedBox(height: 12), // Space between conferences
                  ],
                );
              }),
              // Rating Key Section (conditional)
              if (_showOverallRating)
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
                      // Letter grade ranges instead of numerical
                      ...[
                        {'grade': 'A+', 'range': '97-100', 'rating': 98},
                        {'grade': 'A', 'range': '93-96', 'rating': 94},
                        {'grade': 'A-', 'range': '90-92', 'rating': 91},
                        {'grade': 'B+', 'range': '87-89', 'rating': 88},
                        {'grade': 'B', 'range': '83-86', 'rating': 84},
                        {'grade': 'B-', 'range': '80-82', 'rating': 81},
                        {'grade': 'C+', 'range': '77-79', 'rating': 78},
                        {'grade': 'C', 'range': '73-76', 'rating': 74},
                        {'grade': 'C-', 'range': '70-72', 'rating': 71},
                        {'grade': 'D+', 'range': '67-69', 'rating': 68},
                        {'grade': 'D', 'range': '63-66', 'rating': 64},
                        {'grade': 'D-', 'range': '60-62', 'rating': 61},
                        {'grade': 'F', 'range': '0-59', 'rating': 30},
                      ].map((gradeInfo) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            children: [
                              // Color indicator
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: RatingUtils.getRatingColor(gradeInfo['rating'] as int),
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Letter grade and numerical range
                              Text(
                                '${gradeInfo['grade']} (${gradeInfo['range']})',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.background,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
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
