import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/pages/film_details.dart';
import 'package:swnumar1cs/pages/films.dart';
import 'package:swnumar1cs/pages/main_page.dart';
import 'package:swnumar1cs/pages/people.dart';
import 'package:swnumar1cs/pages/person_details.dart';
import 'package:swnumar1cs/pages/planet_details.dart';
import 'package:swnumar1cs/pages/planets.dart';
import 'package:swnumar1cs/pages/specie_details.dart';
import 'package:swnumar1cs/pages/species.dart';
import 'package:swnumar1cs/pages/starship_details.dart';
import 'package:swnumar1cs/pages/starships.dart';
import 'package:swnumar1cs/pages/vehicle_details.dart';
import 'package:swnumar1cs/pages/vehicles.dart';

class RouterService {
  late final GoRouter _goRouter;

  GoRouter get router => _goRouter;

  RouterService() {
    _buildRouter();
  }

  void _buildRouter() {
    _goRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: MainPage.pageName,
          pageBuilder: (context, state) {
            return _buildMaterialPage(
              key: state.pageKey,
              child: const MainPage(),
            );
          },
        ),
        GoRoute(
          path: '/${Films.pageName}',
          name: Films.pageName,
          pageBuilder: (context, state) {
            return _buildMaterialPage(
              key: state.pageKey,
              child: const Films(),
            );
          },
        ),
        GoRoute(
          path: '/${FilmDetails.pageName}',
          name: FilmDetails.pageName,
          pageBuilder: (context, state) {
            final film = state.extra as Film;
            return _buildMaterialPage(
              key: state.pageKey,
              child: FilmDetails(film: film),
            );
          },
        ),
        GoRoute(
          path: '/${People.pageName}',
          name: People.pageName,
          pageBuilder: (context, state) {
            return _buildMaterialPage(
              key: state.pageKey,
              child: const People(),
            );
          },
        ),
        GoRoute(
          path: '/${PersonDetails.pageName}',
          name: PersonDetails.pageName,
          pageBuilder: (context, state) {
            final person = state.extra as Person;
            return _buildMaterialPage(
              key: state.pageKey,
              child: PersonDetails(person: person),
            );
          },
        ),
        GoRoute(
          path: '/${Planets.pageName}',
          name: Planets.pageName,
          pageBuilder: (context, state) {
            return _buildMaterialPage(
              key: state.pageKey,
              child: const Planets(),
            );
          },
        ),
        GoRoute(
          path: '/${PlanetDetails.pageName}',
          name: PlanetDetails.pageName,
          pageBuilder: (context, state) {
            final planet = state.extra as Planet;
            return _buildMaterialPage(
              key: state.pageKey,
              child: PlanetDetails(planet: planet),
            );
          },
        ),
        GoRoute(
          path: '/${Species.pageName}',
          name: Species.pageName,
          pageBuilder: (context, state) {
            return _buildMaterialPage(
              key: state.pageKey,
              child: const Species(),
            );
          },
        ),
        GoRoute(
          path: '/${SpecieDetails.pageName}',
          name: SpecieDetails.pageName,
          pageBuilder: (context, state) {
            final specie = state.extra as Specie;
            return _buildMaterialPage(
              key: state.pageKey,
              child: SpecieDetails(specie: specie),
            );
          },
        ),
        GoRoute(
          path: '/${Starships.pageName}',
          name: Starships.pageName,
          pageBuilder: (context, state) {
            return _buildMaterialPage(
              key: state.pageKey,
              child: const Starships(),
            );
          },
        ),
        GoRoute(
          path: '/${StarshipDetails.pageName}',
          name: StarshipDetails.pageName,
          pageBuilder: (context, state) {
            final starship = state.extra as Starship;
            return _buildMaterialPage(
              key: state.pageKey,
              child: StarshipDetails(starship: starship),
            );
          },
        ),
        GoRoute(
          path: '/${Vehicles.pageName}',
          name: Vehicles.pageName,
          pageBuilder: (context, state) {
            return _buildMaterialPage(
              key: state.pageKey,
              child: const Vehicles(),
            );
          },
        ),
        GoRoute(
          path: '/${VehicleDetails.pageName}',
          name: VehicleDetails.pageName,
          pageBuilder: (context, state) {
            final vehicle = state.extra as Vehicle;
            return _buildMaterialPage(
              key: state.pageKey,
              child: VehicleDetails(vehicle: vehicle),
            );
          },
        ),
      ],
    );
  }

  Page<void> _buildMaterialPage({required LocalKey key, required Widget child}) {
    return MaterialPage<void>(
      key: key,
      child: child,
    );
  }
}
