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
import 'package:swnumar1cs/providers/specie_details_provider.dart';
import 'package:swnumar1cs/widgets/cell.dart';

class SpecieDetails extends StatelessWidget {
  static const pageName = 'specie_details';

  final Specie specie;

  const SpecieDetails({required this.specie, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SpecieDetailsProvider>(
      create: (context) => SpecieDetailsProvider(specie),
      builder: (context, _) {
        final provider = context.read<SpecieDetailsProvider>();
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.specie.name ?? ''),
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
                      Text('classification: ${provider.specie.classification}'),
                      const SizedBox(height: 8),
                      Text('designation: ${provider.specie.designation}'),
                      const SizedBox(height: 8),
                      Text('average height: ${provider.specie.averageHeight}'),
                      const SizedBox(height: 8),
                      Text('skin colors: ${provider.specie.skinColors}'),
                      const SizedBox(height: 8),
                      Text('hair colors: ${provider.specie.hairColors}'),
                      const SizedBox(height: 8),
                      Text('eye colors: ${provider.specie.eyeColors}'),
                      const SizedBox(height: 8),
                      Text('average lifespan: ${provider.specie.averageLifespan}'),
                      const SizedBox(height: 8),
                      Text('homeworld: ${provider.homeworld?.name ?? ''}'),
                      const SizedBox(height: 8),
                      Text('language: ${provider.specie.language}'),
                    ],
                  ),
                ),
                ExpansionTile(
                  title: Text('people'),
                  children: [
                    for (Person person in provider.people)
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
