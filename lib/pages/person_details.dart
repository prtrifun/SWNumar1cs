import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/pages/film_details.dart';
import 'package:swnumar1cs/pages/specie_details.dart';
import 'package:swnumar1cs/pages/starship_details.dart';
import 'package:swnumar1cs/pages/vehicle_details.dart';
import 'package:swnumar1cs/providers/person_details_provider.dart';
import 'package:swnumar1cs/widgets/cell.dart';

class PersonDetails extends StatelessWidget {
  static const pageName = 'person_details';

  final Person person;

  const PersonDetails({required this.person, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PersonDetailsProvider>(
      create: (context) => PersonDetailsProvider(person),
      builder: (context, _) {
        final provider = context.read<PersonDetailsProvider>();
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.person.name ?? ''),
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
                      Text('height: ${provider.person.height}'),
                      const SizedBox(height: 8),
                      Text('mass: ${provider.person.mass}'),
                      const SizedBox(height: 8),
                      Text('hair color: ${provider.person.hairColor}'),
                      const SizedBox(height: 8),
                      Text('skin color: ${provider.person.skinColor}'),
                      const SizedBox(height: 8),
                      Text('eye color: ${provider.person.eyeColor}'),
                      const SizedBox(height: 8),
                      Text('birth year: ${provider.person.birthYear}'),
                      const SizedBox(height: 8),
                      Text('gender: ${provider.person.gender}'),
                      const SizedBox(height: 8),
                      Text('homeworld: ${provider.planet?.name ?? ''}'),
                    ],
                  ),
                ),
                ExpansionTile(
                  title: Text('films'.tr()),
                  children: [
                    for (Film film in provider.films)
                      Cell(
                        onPressed: () {
                          context.pushNamed(FilmDetails.pageName, extra: film);
                        },
                        title: film.title,
                      )
                  ],
                ),
                ExpansionTile(
                  title: Text('species'.tr()),
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
                ExpansionTile(
                  title: Text('vehicles'.tr()),
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
                  title: Text('starships'.tr()),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
