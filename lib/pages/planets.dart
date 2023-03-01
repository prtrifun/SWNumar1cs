import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/pages/film_details.dart';
import 'package:swnumar1cs/pages/person_details.dart';
import 'package:swnumar1cs/pages/planet_details.dart';
import 'package:swnumar1cs/providers/people_provider.dart';
import 'package:swnumar1cs/providers/planets_provider.dart';
import 'package:swnumar1cs/widgets/cell.dart';

class Planets extends StatelessWidget {
  static const pageName = 'planets';

  const Planets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kPlanets),
      ),
      body: ChangeNotifierProvider<PlanetsProvider>(
        create: (context) => PlanetsProvider(),
        child: Consumer<PlanetsProvider>(
          builder: (context, provider, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (text) {
                      provider.search(text);
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.planets.length,
                      itemBuilder: (context, index) {
                        return Cell(
                          onPressed: () {
                            context.pushNamed(PlanetDetails.pageName, extra: provider.planets[index]);
                          },
                          title: provider.planets[index].name,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
