import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/models/vehicle.dart';

class Film {
  final String? title;
  final int? episodeID;
  final String? openingCrawl;
  final String? director;
  final String? producer;
  final String? releaseDate;
  final List<Person>? characters;
  final List<Planet>? planets;
  final List<Starship>? starships;
  final List<Vehicle>? vehicles;
  final List<Specie>? species;
  final String? url;

  const Film({
    this.title,
    this.episodeID,
    this.openingCrawl,
    this.director,
    this.producer,
    this.releaseDate,
    this.characters,
    this.planets,
    this.starships,
    this.vehicles,
    this.species,
    this.url,
  });

  factory Film.fromJson(Map<String, dynamic> data) {
    return Film(
      title: data['title'],
      episodeID: data['episode_id'],
      openingCrawl: data['opening_crawl'],
      director: data['director'],
      producer: data['producer'],
      releaseDate: data['release_date'],
      url: data['url'],
    );
  }
}
