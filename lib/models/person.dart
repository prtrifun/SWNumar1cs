import 'package:swnumar1cs/models/resource.dart';

class Person extends Resource {
  final String? name;
  final String? height;
  final String? mass;
  final String? hairColor;
  final String? skinColor;
  final String? eyeColor;
  final String? birthYear;
  final String? gender;
  final String? homeworld;
  final List<String> films;
  final List<String> species;
  final List<String> vehicles;
  final List<String> starships;
  final String? url;

  const Person({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films = const [],
    this.species = const [],
    this.vehicles = const [],
    this.starships = const [],
    this.url,
  });

  factory Person.fromJson(Map<String, dynamic> data) {
    final List<String> films = [];
    if (data['films'] != null) {
      for (String film in data['films']) {
        films.add(film);
      }
    }

    final List<String> species = [];
    if (data['species'] != null) {
      for (String specie in data['species']) {
        species.add(specie);
      }
    }

    final List<String> vehicles = [];
    if (data['vehicles'] != null) {
      for (String vehicle in data['vehicles']) {
        vehicles.add(vehicle);
      }
    }

    final List<String> starships = [];
    if (data['starships'] != null) {
      for (String starship in data['starships']) {
        starships.add(starship);
      }
    }

    return Person(
        name: data['name'],
        height: data['height'],
        mass: data['mass'],
        hairColor: data['hair_color'],
        skinColor: data['skin_color'],
        eyeColor: data['eye_color'],
        birthYear: data['birth_year'],
        gender: data['gender'],
        homeworld: data['homeworld'],
        films: films,
        species: species,
        vehicles: vehicles,
        starships: starships,
        url: data['url']);
  }

  @override
  String getWeightedKey1() => name ?? '';

  @override
  String getWeightedKey2() => height ?? '';

  @override
  String getWeightedKey3() => birthYear ?? '';
}
