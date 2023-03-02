import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              child: Text('films'.tr()),
            ),
            FilledButton(
              onPressed: () {
                context.pushNamed(People.pageName);
              },
              child: Text('people'.tr()),
            ),
            FilledButton(
              onPressed: () {
                context.pushNamed(Planets.pageName);
              },
              child: Text('planets'.tr()),
            ),
            FilledButton(
              onPressed: () {
                context.pushNamed(Species.pageName);
              },
              child: Text('species'.tr()),
            ),
            FilledButton(
              onPressed: () {
                context.pushNamed(Starships.pageName);
              },
              child: Text('starships'.tr()),
            ),
            FilledButton(
              onPressed: () {
                context.pushNamed(Vehicles.pageName);
              },
              child: Text('vehicles'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
