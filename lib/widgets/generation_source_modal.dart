import 'package:flutter/material.dart';
import 'package:pocket_gm_generator/pocket_gm_generator.dart';
import '../theme/colors.dart';
import 'team_selection_modal.dart';

class GenerationSourceModal extends StatelessWidget {
  const GenerationSourceModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      content: Text(
        'Do you want to generate a league or load an online roster file?',
        style: TextStyle(
          color: AppColors.background,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Wrap(
          alignment: WrapAlignment.end,
          spacing: 8.0,
          children: [
            TextButton(
              onPressed: () {
                // TODO: Implement Load from Online functionality
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
              ),
              child: const Text(
                'Load from Online',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _generateLeagueAndShowTeamSelection(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
              ),
              child: const Text(
                'Generate',
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
  }

  void _generateLeagueAndShowTeamSelection(BuildContext context) {
    // Generate the league using the league generator
    final LeagueGenerator generator = LeagueGenerator();
    final League league = generator.generateLeague();

    // Show the team selection modal
    showDialog(
      context: context,
      barrierDismissible: false, // Force user to choose a team
      builder: (BuildContext context) {
        return TeamSelectionModal(
          league: league,
          onTeamSelected: (Team selectedTeam) {
            // TODO: Handle team selection - save to state/preferences
            debugPrint('Selected team: ${selectedTeam.city} ${selectedTeam.name}');
          },
        );
      },
    );
  }
}
