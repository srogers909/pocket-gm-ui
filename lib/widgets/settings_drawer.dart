import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';
import '../generated/app_localizations.dart';
import '../theme/colors.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Drawer(
      backgroundColor: AppColors.surface,
      child: Column(
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.settings,
                  color: AppColors.onPrimary,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Text(
                  localizations.settings,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Language Selection Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.language,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Language Options
                ...localeProvider.supportedLocales.map((localeInfo) {
                  final isSelected = localeProvider.locale == localeInfo.locale;
                  
                  return Card(
                    color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
                    elevation: isSelected ? 2 : 0,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.language,
                        color: isSelected ? AppColors.primary : AppColors.onSurface.withOpacity(0.6),
                      ),
                      title: Text(
                        localeInfo.displayName,
                        style: TextStyle(
                          color: isSelected ? AppColors.primary : AppColors.onSurface,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      trailing: isSelected 
                        ? Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                          )
                        : null,
                      onTap: () {
                        localeProvider.setLocale(localeInfo.locale);
                        Navigator.of(context).pop(); // Close the drawer
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          
          const Spacer(),
          
          // Footer or additional settings can go here
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Pocket GM v1.0.0',
              style: TextStyle(
                color: AppColors.onSurface,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
