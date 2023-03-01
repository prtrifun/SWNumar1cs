import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/services/people_service.dart';
import 'package:swnumar1cs/services/planets_service.dart';
import 'package:swnumar1cs/services/species_service.dart';
import 'package:swnumar1cs/services/starships_service.dart';
import 'package:swnumar1cs/services/vehicles_service.dart';

class FilmDetailsProvider extends ChangeNotifier {
  final _peopleService = KiwiContainer().resolve<PeopleService>();
  final _planetsService = KiwiContainer().resolve<PlanetsService>();
  final _starshipsService = KiwiContainer().resolve<StarshipsService>();
  final _vehiclesService = KiwiContainer().resolve<VehiclesService>();
  final _speciesService = KiwiContainer().resolve<SpeciesService>();

  final Film film;

  List<Person> get characters => _peopleService.getPeople(urls: film.characters);
  List<Planet> get planets => _planetsService.getPlanets(urls: film.planets);
  List<Starship> get starships => _starshipsService.getStarships(urls: film.starships);
  List<Vehicle> get vehicles => _vehiclesService.getVehicles(urls: film.vehicles);
  List<Specie> get species => _speciesService.getSpecies(urls: film.species);

  FilmDetailsProvider(this.film);
}
