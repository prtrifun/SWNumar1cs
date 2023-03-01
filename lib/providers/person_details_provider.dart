import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/services/films_service.dart';
import 'package:swnumar1cs/services/people_service.dart';
import 'package:swnumar1cs/services/planets_service.dart';
import 'package:swnumar1cs/services/species_service.dart';
import 'package:swnumar1cs/services/starships_service.dart';
import 'package:swnumar1cs/services/vehicles_service.dart';

class PersonDetailsProvider extends ChangeNotifier {
  final _planetsService = KiwiContainer().resolve<PlanetsService>();
  final _filmsService = KiwiContainer().resolve<FilmsService>();
  final _speciesService = KiwiContainer().resolve<SpeciesService>();
  final _vehiclesService = KiwiContainer().resolve<VehiclesService>();
  final _starshipsService = KiwiContainer().resolve<StarshipsService>();

  final Person person;

  Planet? get planet => _planetsService.getPlanet(url: person.homeworld);
  List<Film> get films => _filmsService.getFilms(urls: person.films);
  List<Specie> get species => _speciesService.getSpecies(urls: person.species);
  List<Vehicle> get vehicles => _vehiclesService.getVehicles(urls: person.vehicles);
  List<Starship> get starships => _starshipsService.getStarships(urls: person.starships);

  PersonDetailsProvider(this.person);
}
