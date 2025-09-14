import 'package:flutter/material.dart';
import 'package:pocket_gm_generator/pocket_gm_generator.dart';
import '../theme/colors.dart';

/// TeamDashboardScreen
/// Empty placeholder destination after team selection.
/// Accepts a [Team] to allow future expansion (stats, schedule, morale, etc.).
class TeamDashboardScreen extends StatelessWidget {
  final Team team;

  const TeamDashboardScreen({
    super.key,
    required this.team,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        title: Text(
          '${team.name} Dashboard',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Team Dashboard Placeholder\n(${team.name})',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: AppColors.surface,
          ),
        ),
      ),
    );
  }
}
