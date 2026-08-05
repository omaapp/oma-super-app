import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/app_settings.dart';
import '../core/theme/app_theme.dart';

import '../l10n/app_localizations.dart';

import '../features/splash/presentation/splash_screen.dart';
import '../features/customer/map/presentation/map_screen.dart';
import '../features/trip/presentation/driver_arriving_screen.dart';
import '../features/customer/navigation/presentation/main_navigation.dart';
import 'app_routes.dart';
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

      initialRoute: AppRoutes.splash,

      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        // MainNavigation owns the customer tabs; HomeScreen is its first tab.
        AppRoutes.home: (_) => const MainNavigation(),
        AppRoutes.map: (_) => const MapScreen(),
      },

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.driverArriving:
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
