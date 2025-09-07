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
            children: league.conferences.map((conference) {
              // Use different colors for each conference
              final Color conferenceColor = conference.name == 'AFC' 
                  ? AppColors.primary 
                  : const Color(0xFF1976D2); // Blue color for NFC

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
                        // Team Buttons for this division
                        ...division.teams.map((team) {
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      team.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      team.division ?? '',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
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
          ),
        ),
      ),
    );
  }
}
