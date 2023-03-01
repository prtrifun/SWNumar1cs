import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/vehicle.dart';
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
                  title: Text('pilots'),
                  children: [
                    for (Person person in provider.pilots)
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
