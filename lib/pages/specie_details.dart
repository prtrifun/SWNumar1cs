import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/pages/film_details.dart';
import 'package:swnumar1cs/pages/person_details.dart';
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
                  title: Text('people'.tr()),
                  children: [
                    for (Person person in provider.people)
                      Cell(
                        onPressed: () {
                          context.pushNamed(PersonDetails.pageName, extra: person);
                        },
                        title: person.name,
                      )
                  ],
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
              ],
            ),
          ),
        );
      },
    );
  }
}
