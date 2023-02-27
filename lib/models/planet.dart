import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';

class Planet {
  final String? name;
  final String? rotationPeriod;
  final String? orbitalPeriod;
  final String? diameter;
  final String? climate;
  final String? gravity;
  final String? terrain;
  final String? surfaceWater;
  final String? population;
  final List<Person>? residents;
  final List<Film>? films;
  final String? url;

  const Planet({
    this.name,
    this.rotationPeriod,
    this.orbitalPeriod,
    this.diameter,
    this.climate,
    this.gravity,
    this.terrain,
    this.surfaceWater,
    this.population,
    this.residents,
    this.films,
    this.url,
  });

  factory Planet.fromJson(Map<String, dynamic> data) {
    return Planet(
      name: data['name'],
      rotationPeriod: data['rotation_period'],
      orbitalPeriod: data['orbital_period'],
      diameter: data['diameter'],
      climate: data['climate'],
      gravity: data['gravity'],
      terrain: data['terrain'],
      surfaceWater: data['surface_water'],
      population: data['population'],
      url: data['url'],
    );
  }
}
