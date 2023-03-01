class Vehicle {
  final String? name;
  final String? model;
  final String? manufacturer;
  final String? costInCredits;
  final String? length;
  final String? maxAtmospheringSpeed;
  final String? crew;
  final String? passengers;
  final String? cargoCapacity;
  final String? consumables;
  final String? vehicleClass;
  final List<String> pilots;
  final List<String> films;
  final String? url;

  const Vehicle({
    this.name,
    this.model,
    this.manufacturer,
    this.costInCredits,
    this.length,
    this.maxAtmospheringSpeed,
    this.crew,
    this.passengers,
    this.cargoCapacity,
    this.consumables,
    this.vehicleClass,
    this.pilots = const [],
    this.films = const [],
    this.url,
  });

  factory Vehicle.fromJson(Map<String, dynamic> data) {
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

    return Vehicle(
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
      vehicleClass: data['vehicle_class'],
      pilots: pilots,
      films: films,
      url: data['url'],
    );
  }
}
