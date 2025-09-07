import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'screens/cover_page.dart';
import 'screens/main_scaffold.dart';
import 'theme/colors.dart';
import 'generated/app_localizations.dart';
import 'providers/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
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
    return ChangeNotifierProvider.value(
      value: localeProvider,
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
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primary,
                brightness: Brightness.dark,
              ).copyWith(
                primary: AppColors.primary,
                secondary: AppColors.secondary,
                surface: AppColors.surface,
                onPrimary: AppColors.onPrimary,
                onSecondary: AppColors.onSecondary,
                onSurface: AppColors.onSurface,
              ),
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.background,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              dialogTheme: const DialogThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
              ),
            ),
            home: const MainScaffold(
              body: CoverPage(),
            ),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
