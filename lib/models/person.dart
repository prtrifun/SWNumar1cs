import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/models/vehicle.dart';

class Person {
  final String? name;
  final String? height;
  final String? mass;
  final String? hairColor;
  final String? skinColor;
  final String? eyeColor;
  final String? birthYear;
  final String? gender;
  final String? homeworld;
  final List<Film>? films;
  final List<Specie>? species;
  final List<Vehicle>? vehicles;
  final List<Starship>? starships;
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
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.url,
  });

  factory Person.fromJson(Map<String, dynamic> data) {
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
        url: data['']);
  }
}
