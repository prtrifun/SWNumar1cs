import 'dart:async';

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

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    initKiwi();
    await KiwiContainer().resolve<FilmsService>().init();
    await KiwiContainer().resolve<PeopleService>().init();
    await KiwiContainer().resolve<PlanetsService>().init();
    await KiwiContainer().resolve<SpeciesService>().init();
    await KiwiContainer().resolve<StarshipsService>().init();
    await KiwiContainer().resolve<VehiclesService>().init();

    runApp(const MyApp());
  }, (error, stackTrace) {
    //  TODO: log and handle error
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = KiwiContainer().resolve<RouterService>().router;
    return MaterialApp.router(
      title: 'Star Wars Fan App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}
