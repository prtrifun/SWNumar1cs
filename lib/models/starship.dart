import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/vehicle.dart';

class Starship extends Vehicle {
  final String? hyperdriveRating;
  final String? mglt;
  final String? starshipClass;

  const Starship({
    String? name,
    String? model,
    String? manufacturer,
    String? costInCredits,
    String? length,
    String? maxAtmospheringSpeed,
    String? crew,
    String? passengers,
    String? cargoCapacity,
    String? consumables,
    this.hyperdriveRating,
    this.mglt,
    this.starshipClass,
    List<Person>? pilots,
    List<Film>? films,
    String? url,
  }) : super(
          name: name,
          model: model,
          manufacturer: manufacturer,
          costInCredits: costInCredits,
          length: length,
          maxAtmospheringSpeed: maxAtmospheringSpeed,
          crew: crew,
          passengers: passengers,
          cargoCapacity: cargoCapacity,
          consumables: consumables,
          pilots: pilots,
          films: films,
          url: url,
        );

  factory Starship.fromJson(Map<String, dynamic> data) {
    return Starship(
      name: data['name'],
      model: data['model'],
      manufacturer: data['manufacturer'],
      costInCredits: data['cost_in_credits'],
      length: data['length'],
      maxAtmospheringSpeed: data['max_atmosphering_speed'],
      crew: data['crew'],
      passengers: data['passengers'],
      cargoCapacity: data['cargo_capacity'],
      consumables: data['consumables'],
      hyperdriveRating: data['hyperdrive_rating'],
      mglt: data['MGLT'],
      starshipClass: data['starship_class'],
      url: data['url'],
    );
  }
}
