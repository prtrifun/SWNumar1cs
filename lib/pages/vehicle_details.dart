import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/pages/film_details.dart';
import 'package:swnumar1cs/pages/person_details.dart';
import 'package:swnumar1cs/providers/vehicle_details_provider.dart';
import 'package:swnumar1cs/widgets/cell.dart';

class VehicleDetails extends StatelessWidget {
  static const pageName = 'vehicle_details';

  final Vehicle vehicle;

  const VehicleDetails({required this.vehicle, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VehicleDetailsProvider>(
      create: (context) => VehicleDetailsProvider(vehicle),
      builder: (context, _) {
        final provider = context.read<VehicleDetailsProvider>();
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.vehicle.name ?? ''),
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
                      Text('model: ${vehicle.model}'),
                      const SizedBox(height: 8),
                      Text('manufacturer: ${vehicle.manufacturer}'),
                      const SizedBox(height: 8),
                      Text('cost in credits: ${vehicle.costInCredits}'),
                      const SizedBox(height: 8),
                      Text('length: ${vehicle.length}'),
                      const SizedBox(height: 8),
                      Text('max atmosphering speed: ${vehicle.maxAtmospheringSpeed}'),
                      const SizedBox(height: 8),
                      Text('crew: ${vehicle.crew}'),
                      const SizedBox(height: 8),
                      Text('passengers: ${vehicle.passengers}'),
                      const SizedBox(height: 8),
                      Text('cargo capacity: ${vehicle.cargoCapacity}'),
                      const SizedBox(height: 8),
                      Text('consumables: ${vehicle.consumables}'),
                      const SizedBox(height: 8),
                      Text('vehicle class: ${vehicle.vehicleClass}'),
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
