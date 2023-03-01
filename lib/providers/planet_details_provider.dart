import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/pages/people.dart';
import 'package:swnumar1cs/services/films_service.dart';
import 'package:swnumar1cs/services/people_service.dart';
import 'package:swnumar1cs/services/planets_service.dart';
import 'package:swnumar1cs/services/species_service.dart';
import 'package:swnumar1cs/services/starships_service.dart';
import 'package:swnumar1cs/services/vehicles_service.dart';

class PlanetDetailsProvider extends ChangeNotifier {
  final _peopleService = KiwiContainer().resolve<PeopleService>();
  final _filmsService = KiwiContainer().resolve<FilmsService>();

  final Planet planet;

  List<Person> get residents => _peopleService.getPeople(urls: planet.residents);
  List<Film> get films => _filmsService.getFilms(urls: planet.films);

  PlanetDetailsProvider(this.planet);
}
