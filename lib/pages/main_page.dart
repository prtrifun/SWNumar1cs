import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/pages/films.dart';
import 'package:swnumar1cs/pages/people.dart';
import 'package:swnumar1cs/pages/planets.dart';
import 'package:swnumar1cs/pages/species.dart';
import 'package:swnumar1cs/pages/starships.dart';
import 'package:swnumar1cs/pages/vehicles.dart';

class MainPage extends StatelessWidget {
  static const pageName = 'mainPage';

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                context.pushNamed(Films.pageName);
              },
              child: const Text(kFilms),
            ),
            FilledButton(
              onPressed: () {
                context.pushNamed(People.pageName);
              },
              child: const Text(kPeople),
            ),
            FilledButton(
              onPressed: () {
                context.pushNamed(Planets.pageName);
              },
              child: const Text(kPlanets),
            ),
            FilledButton(
              onPressed: () {
                context.pushNamed(Species.pageName);
              },
              child: const Text(kSpecies),
            ),
            FilledButton(
              onPressed: () {
                context.pushNamed(Starships.pageName);
              },
              child: const Text(kStarships),
            ),
            FilledButton(
              onPressed: () {
                context.pushNamed(Vehicles.pageName);
              },
              child: const Text(kVehicles),
            ),
          ],
        ),
      ),
    );
  }
}
