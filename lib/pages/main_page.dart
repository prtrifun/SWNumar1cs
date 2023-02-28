import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/pages/films.dart';

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
              onPressed: () {},
              child: const Text(kPeople),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text(kPlanets),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text(kSpecies),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text(kStarships),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text(kVehicles),
            ),
          ],
        ),
      ),
    );
  }
}
