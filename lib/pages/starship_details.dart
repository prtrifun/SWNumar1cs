import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/pages/film_details.dart';
import 'package:swnumar1cs/pages/person_details.dart';
import 'package:swnumar1cs/providers/starship_details_provider.dart';
import 'package:swnumar1cs/widgets/cell.dart';

class StarshipDetails extends StatelessWidget {
  static const pageName = 'starship_details';

  final Starship starship;

  const StarshipDetails({required this.starship, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StarshipDetailsProvider>(
      create: (context) => StarshipDetailsProvider(starship),
      builder: (context, _) {
        final provider = context.read<StarshipDetailsProvider>();
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.starship.name ?? ''),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
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
                      Text('${'model'.tr()}: ${starship.model}'),
                      const SizedBox(height: 8),
                      Text('${'manufacturer'.tr()}: ${starship.manufacturer}'),
                      const SizedBox(height: 8),
                      Text('${'cost_in_credits'.tr()}: ${starship.costInCredits}'),
                      const SizedBox(height: 8),
                      Text('${'length'.tr()}: ${starship.length}'),
                      const SizedBox(height: 8),
                      Text('${'max_atmosphering_speed'.tr()}: ${starship.maxAtmospheringSpeed}'),
                      const SizedBox(height: 8),
                      Text('${'crew'.tr()}: ${starship.crew}'),
                      const SizedBox(height: 8),
                      Text('${'passengers'.tr()}: ${starship.passengers}'),
                      const SizedBox(height: 8),
                      Text('${'cargo_capacity'.tr()}: ${starship.cargoCapacity}'),
                      const SizedBox(height: 8),
                      Text('${'consumables'.tr()}: ${starship.consumables}'),
                      const SizedBox(height: 8),
                      Text('${'hyperdrive_rating'.tr()}: ${starship.hyperdriveRating}'),
                      const SizedBox(height: 8),
                      Text('${'mglt'.tr()}: ${starship.mglt}'),
                      const SizedBox(height: 8),
                      Text('${'starship_class'.tr()}: ${starship.starshipClass}'),
                    ],
                  ),
                ),
                ExpansionTile(
                  title: Text('pilots'.tr()),
                  children: [
                    for (Person person in provider.pilots)
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
