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
    List<String> pilots = const [],
    List<String> films = const [],
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
    final List<String> pilots = [];
    if (data['pilots'] != null) {
      for (String pilot in data['pilots']) {
        pilots.add(pilot);
      }
    }

    final List<String> films = [];
    if (data['films'] != null) {
      for (String film in data['films']) {
        films.add(film);
      }
    }

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
      pilots: pilots,
      films: films,
      url: data['url'],
    );
  }

  @override
  String getWeightedKey1() => name ?? '';

  @override
  String getWeightedKey2() => starshipClass ?? '';

  @override
  String getWeightedKey3() => model ?? '';
}
