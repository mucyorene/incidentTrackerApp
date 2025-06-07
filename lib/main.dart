import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart' show Hive, HiveX;
import 'package:incident_tracker_app/models/create_incident.dart';
import 'package:incident_tracker_app/routers/ita_routers.dart' show itaRouters;
import 'package:incident_tracker_app/theme/theme.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CreateIncidentAdapter());
  await Hive.openBox<CreateIncident>('incidentDb');
  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en', 'US'), const Locale('fr', 'FR')],
      path: 'assets/translations',
      startLocale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      useFallbackTranslations: true,
      assetLoader: const RootBundleAssetLoader(),
      child: const ProviderScope(child: IncidentAppTracker()),
    ),
  );
}

class IncidentAppTracker extends StatelessWidget {
  const IncidentAppTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Incident tracker app',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [...context.localizationDelegates],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      routeInformationParser: itaRouters.routeInformationParser,
      routerDelegate: itaRouters.routerDelegate,
      routeInformationProvider: itaRouters.routeInformationProvider,
    );
  }
}
