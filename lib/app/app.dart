import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/app_settings.dart';
import '../core/theme/app_theme.dart';

import '../l10n/app_localizations.dart';

import '../features/splash/presentation/splash_screen.dart';
import '../features/customer/home/presentation/home_screen.dart';
import '../features/customer/map/presentation/map_screen.dart';
import '../features/trip/presentation/driver_arriving_screen.dart';

class OmaApp extends StatelessWidget {
  const OmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    return MaterialApp(
      title: "OMA",

      debugShowCheckedModeBanner: false,

      locale: settings.locale,

      supportedLocales: AppLocalizations.supportedLocales,

      localizationsDelegates:
          AppLocalizations.localizationsDelegates,

      themeMode: settings.themeMode,

      theme: AppTheme.light,

      darkTheme: AppTheme.dark,

      initialRoute: "/",

      routes: {
        "/": (context) => const SplashScreen(),

        "/home": (context) => const HomeScreen(),

        "/map": (context) => const MapScreen(),
      },

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/driver-arriving":
            final tripId = settings.arguments as String;

            return MaterialPageRoute(
              builder: (_) => DriverArrivingScreen(
                tripId: tripId,
              ),
            );
        }

        return null;
      },
    );
  }
}