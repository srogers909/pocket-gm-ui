import 'package:flutter/material.dart';
import '../theme/colors.dart';

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
                // TODO: Implement Generate functionality
                Navigator.of(context).pop();
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
}
