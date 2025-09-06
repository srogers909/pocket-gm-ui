import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'generation_source_modal.dart';

class SaveSlotModal extends StatelessWidget {
  final String title;

  const SaveSlotModal({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.background,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Save slot buttons
            for (int i = 1; i <= 3; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Close current dialog
                      Navigator.of(context).pop();
                      // Open generation source modal
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const GenerationSourceModal();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bigMachine4,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      elevation: 2,
                    ),
                    child: const Text(
                      'EMPTY',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
