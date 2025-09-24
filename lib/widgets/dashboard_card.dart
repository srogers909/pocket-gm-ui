import 'package:flutter/material.dart';

/// Reusable boxed dashboard card with a consistent border and margin
/// picking up styling from ThemeData.cardTheme.
/// Place content via the [child] parameter. The [title] is rendered
/// as an expandable tile that can be collapsed/expanded.
class DashboardCard extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsetsGeometry contentPadding;
  final bool initiallyExpanded;

  const DashboardCard({
    super.key,
    required this.title,
    required this.child,
    this.contentPadding = const EdgeInsets.all(12),
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        title: Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: contentPadding,
            child: child,
          ),
        ],
      ),
    );
  }
}
