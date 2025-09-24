import 'package:flutter/material.dart';
import '../generated/app_localizations.dart';
import 'package:pocket_gm_generator/pocket_gm_generator.dart';
import '../theme/colors.dart';
import 'team_selection_modal.dart';

class GenerationSourceModal extends StatelessWidget {
  const GenerationSourceModal({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return AlertDialog(
      backgroundColor: AppColors.surface,
      content: Text(
        localizations.generationSourceQuestion,
        style: TextStyle(
          color: AppColors.onSurface,
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
              child: Text(
                localizations.loadFromOnline,
                style: const TextStyle(
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
              child: Text(
                localizations.generate,
                style: const TextStyle(
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
            // Navigation & provider updates are handled inside TeamSelectionModal's
            // confirmation flow. We intentionally do NOT push a new route here to
            // avoid rendering the dashboard on a standalone route (which caused
            // the black background flash before the main scaffold appeared).
            // This callback is retained for future extensibility.
          },
        );
      },
    );
  }
}
