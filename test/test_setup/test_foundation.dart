import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Future<Widget> testSetup({
  required Widget w,
  required Locale testLocale,
}) async {
  var path =
      "assets/translations/${testLocale.toStringWithSeparator(separator: "-")}.json";
  var s = json.decode(await rootBundle.loadString(path));
  return Builder(
    builder: (context) {
      return EasyLocalization(
        fallbackLocale: const Locale('en', 'US'),
        useFallbackTranslations: true,
        assetLoader: TestJsonAsset(data: Map<String, dynamic>.from(s)),
        saveLocale: false,
        startLocale: testLocale,
        path: 'assets/translations',
        supportedLocales: [Locale('en', 'US'), Locale('fr', 'FR')],
        child: ProviderScope(
          child: Builder(
            builder: (context) {
              return MaterialApp.router(
                localizationsDelegates: [...context.localizationDelegates],
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                routerDelegate: getGoRouter(w).routerDelegate,
                routeInformationParser: getGoRouter(w).routeInformationParser,
                routeInformationProvider:
                    getGoRouter(w).routeInformationProvider,
              );
            },
          ),
        ),
      );
    },
  );
}

class TestJsonAsset extends AssetLoader {
  final Map<String, dynamic> data;

  const TestJsonAsset({this.data = const {}});

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) async {
    return Future.value(data);
  }
}

GoRouter getGoRouter(Widget w) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return Material(child: w);
        },
      ),
    ],
    initialLocation: "/",
  );
}
