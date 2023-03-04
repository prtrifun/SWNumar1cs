import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/injection_container.dart';
import 'package:swnumar1cs/services/films_service.dart';
import 'package:swnumar1cs/services/people_service.dart';
import 'package:swnumar1cs/services/planets_service.dart';
import 'package:swnumar1cs/services/router_service.dart';
import 'package:swnumar1cs/services/species_service.dart';
import 'package:swnumar1cs/services/starships_service.dart';
import 'package:swnumar1cs/services/vehicles_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  initKiwi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = KiwiContainer().resolve<RouterService>().router;
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      path: 'assets/localization',
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'Star Wars Fan App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routerConfig: router,
            locale: context.locale,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
          );
        },
      ),
    );
  }
}
