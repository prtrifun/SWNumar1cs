import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/pages/person_details.dart';
import 'package:swnumar1cs/pages/planet_details.dart';
import 'package:swnumar1cs/pages/specie_details.dart';
import 'package:swnumar1cs/pages/starship_details.dart';
import 'package:swnumar1cs/pages/vehicle_details.dart';
import 'package:swnumar1cs/providers/film_details_provider.dart';
import 'package:swnumar1cs/widgets/cell.dart';

class FilmDetails extends StatelessWidget {
  static const pageName = 'film_details';

  final Film film;

  const FilmDetails({required this.film, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FilmDetailsProvider>(
      create: (context) => FilmDetailsProvider(film),
      builder: (context, _) {
        final provider = context.read<FilmDetailsProvider>();
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.film.title ?? ''),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )
            ],
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
                      Text('episode: ${provider.film.episodeID}'),
                      const SizedBox(height: 8),
                      Text('openingCrawl:\n\n${provider.film.openingCrawl}'),
                      const SizedBox(height: 8),
                      Text('director: ${provider.film.director}'),
                      const SizedBox(height: 8),
                      Text('producer: ${provider.film.producer}'),
                      const SizedBox(height: 8),
                      Text('releaseDate: ${provider.film.releaseDate}'),
                    ],
                  ),
                ),
                ExpansionTile(
                  title: Text('characters'),
                  children: [
                    for (Person person in provider.characters)
                      Cell(
                        onPressed: () {
                          context.pushNamed(PersonDetails.pageName, extra: person);
                        },
                        title: person.name,
                      )
                  ],
                ),
                ExpansionTile(
                  title: Text('planets'),
                  children: [
                    for (Planet planet in provider.planets)
                      Cell(
                        onPressed: () {
                          context.pushNamed(PlanetDetails.pageName, extra: planet);
                        },
                        title: planet.name,
                      )
                  ],
                ),
                ExpansionTile(
                  title: Text('starships'),
                  children: [
                    for (Starship starship in provider.starships)
                      Cell(
                        onPressed: () {
                          context.pushNamed(StarshipDetails.pageName, extra: starship);
                        },
                        title: starship.name,
                      )
                  ],
                ),
                ExpansionTile(
                  title: Text('vehicles'),
                  children: [
                    for (Vehicle vehicle in provider.vehicles)
                      Cell(
                        onPressed: () {
                          context.pushNamed(VehicleDetails.pageName, extra: vehicle);
                        },
                        title: vehicle.name,
                      )
                  ],
                ),
                ExpansionTile(
                  title: Text('species'),
                  children: [
                    for (Specie specie in provider.species)
                      Cell(
                        onPressed: () {
                          context.pushNamed(SpecieDetails.pageName, extra: specie);
                        },
                        title: specie.name,
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
