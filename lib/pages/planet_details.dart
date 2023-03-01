import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/providers/film_details_provider.dart';
import 'package:swnumar1cs/providers/person_details_provider.dart';
import 'package:swnumar1cs/providers/planet_details_provider.dart';
import 'package:swnumar1cs/widgets/cell.dart';

class PlanetDetails extends StatelessWidget {
  static const pageName = 'planet_details';

  final Planet planet;

  const PlanetDetails({required this.planet, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlanetDetailsProvider>(
      create: (context) => PlanetDetailsProvider(planet),
      builder: (context, _) {
        final provider = context.read<PlanetDetailsProvider>();
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.planet.name ?? ''),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('rotation period: ${provider.planet.rotationPeriod}'),
                      const SizedBox(height: 8),
                      Text('orbital period: ${provider.planet.orbitalPeriod}'),
                      const SizedBox(height: 8),
                      Text('diameter: ${provider.planet.diameter}'),
                      const SizedBox(height: 8),
                      Text('climate: ${provider.planet.climate}'),
                      const SizedBox(height: 8),
                      Text('gravity: ${provider.planet.gravity}'),
                      const SizedBox(height: 8),
                      Text('terrain: ${provider.planet.terrain}'),
                      const SizedBox(height: 8),
                      Text('surface water: ${provider.planet.surfaceWater}'),
                      const SizedBox(height: 8),
                      Text('population: ${provider.planet.population ?? ''}'),
                    ],
                  ),
                ),
                ExpansionTile(
                  title: Text('residents'),
                  children: [
                    for (Person person in provider.residents)
                      Cell(
                        onPressed: () {},
                        title: person.name,
                      )
                  ],
                ),
                ExpansionTile(
                  title: Text('films'),
                  children: [
                    for (Film film in provider.films)
                      Cell(
                        onPressed: () {},
                        title: film.title,
                      )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}