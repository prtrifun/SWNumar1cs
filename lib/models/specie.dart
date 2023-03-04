import 'package:swnumar1cs/models/resource.dart';

class Specie extends Resource {
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
  final List<String> people;
  final List<String> films;
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
    this.people = const [],
    this.films = const [],
    this.url,
  });

  factory Specie.fromJson(Map<String, dynamic> data) {
    final List<String> people = [];
    if (data['people'] != null) {
      for (String person in data['people']) {
        people.add(person);
      }
    }

    final List<String> films = [];
    if (data['films'] != null) {
      for (String film in data['films']) {
        films.add(film);
      }
    }

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
      people: people,
      films: films,
      url: data['url'],
    );
  }

  @override
  String getWeightedKey1() => name ?? '';

  @override
  String getWeightedKey2() => classification ?? '';

  @override
  String getWeightedKey3() => language ?? '';
}
