import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'screens/main_scaffold.dart';
import 'theme/colors.dart';
import 'generated/app_localizations.dart';
import 'providers/locale_provider.dart';
import 'providers/team_provider.dart';
import 'providers/navigation_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Orientation unlocked: allow all supported orientations (portrait & landscape).
  
  // Hide system navigation and status bars
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [],
  );
  
  // Initialize the locale provider
  final localeProvider = LocaleProvider();
  await localeProvider.initialize();
  
  runApp(PocketGMApp(localeProvider: localeProvider));
}

class PocketGMApp extends StatelessWidget {
  final LocaleProvider localeProvider;
  
  const PocketGMApp({super.key, required this.localeProvider});

  @override
  Widget build(BuildContext context) {
return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: localeProvider),
          ChangeNotifierProvider(create: (_) => TeamProvider()),
          ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ],
        child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            title: 'Pocket GM',
            locale: localeProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('es'), // Spanish
              Locale('fr'), // French
              Locale('de'), // German
            ],
            theme: ThemeData(
              // Midnight high-contrast theme
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.background,
              colorScheme: const ColorScheme(
                brightness: Brightness.dark,
                primary: AppColors.primary,
                onPrimary: AppColors.onPrimary,
                secondary: AppColors.secondary,
                onSecondary: AppColors.onSecondary,
                error: Colors.redAccent,
                onError: Colors.white,
                surface: AppColors.surface,
                onSurface: AppColors.onSurface,
              ),
              textTheme: Typography.whiteMountainView.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.background,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              dividerColor: AppColors.midnightSecondary,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.link, // links = yellow
                ),
              ),
              dialogTheme: const DialogThemeData(
                backgroundColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
              ),
              cardTheme: CardThemeData(
                color: AppColors.surface,
                margin: const EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 0,
              ),
            ),
            home: const MainScaffold(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
