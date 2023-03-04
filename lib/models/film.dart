import 'package:swnumar1cs/models/resource.dart';

class Film extends Resource {
  final String? title;
  final int? episodeID;
  final String? openingCrawl;
  final String? director;
  final String? producer;
  final String? releaseDate;
  final List<String> characters;
  final List<String> planets;
  final List<String> starships;
  final List<String> vehicles;
  final List<String> species;
  final String? url;

  const Film({
    this.title,
    this.episodeID,
    this.openingCrawl,
    this.director,
    this.producer,
    this.releaseDate,
    this.characters = const [],
    this.planets = const [],
    this.starships = const [],
    this.vehicles = const [],
    this.species = const [],
    this.url,
  });

  factory Film.fromJson(Map<String, dynamic> data) {
    final List<String> characters = [];
    if (data['characters'] != null) {
      for (String character in data['characters']) {
        characters.add(character);
      }
    }

    final List<String> planets = [];
    if (data['planets'] != null) {
      for (String planet in data['planets']) {
        planets.add(planet);
      }
    }

    final List<String> starships = [];
    if (data['starships'] != null) {
      for (String starship in data['starships']) {
        starships.add(starship);
      }
    }

    final List<String> vehicles = [];
    if (data['vehicles'] != null) {
      for (String vehicle in data['vehicles']) {
        vehicles.add(vehicle);
      }
    }

    final List<String> species = [];
    if (data['species'] != null) {
      for (String specie in data['species']) {
        species.add(specie);
      }
    }

    return Film(
      title: data['title'],
      episodeID: data['episode_id'],
      openingCrawl: data['opening_crawl'],
      director: data['director'],
      producer: data['producer'],
      releaseDate: data['release_date'],
      characters: characters,
      planets: planets,
      starships: starships,
      vehicles: vehicles,
      species: species,
      url: data['url'],
    );
  }

  @override
  String getWeightedKey1() => title ?? '';

  @override
  String getWeightedKey2() => director ?? '';

  @override
  String getWeightedKey3() => producer ?? '';
}
