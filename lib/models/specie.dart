import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';

class Specie {
  final String? name;
  final String? classification;
  final String? designation;
  final String? averageHeight;
  final String? skinColors;
  final String? hairColors;
  final String? eyeColors;
  final String? averageLifespan;
  final String? homeworld;
  final String? language;
  final List<Person>? people;
  final List<Film>? films;
  final String? url;

  const Specie({
    this.name,
    this.classification,
    this.designation,
    this.averageHeight,
    this.skinColors,
    this.hairColors,
    this.eyeColors,
    this.averageLifespan,
    this.homeworld,
    this.language,
    this.people,
    this.films,
    this.url,
  });

  factory Specie.fromJson(Map<String, dynamic> data) {
    return Specie(
      name: data['name'],
      classification: data['classification'],
      designation: data['designation'],
      averageHeight: data['average_height'],
      skinColors: data['skin_colors'],
      hairColors: data['hair_colors'],
      eyeColors: data['eye_colors'],
      averageLifespan: data['average_lifespan'],
      homeworld: data['homeworld'],
      language: data['language'],
      url: data['url'],
    );
  }
}
