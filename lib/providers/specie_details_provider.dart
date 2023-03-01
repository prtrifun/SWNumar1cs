import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/services/films_service.dart';
import 'package:swnumar1cs/services/people_service.dart';
import 'package:swnumar1cs/services/planets_service.dart';

class SpecieDetailsProvider extends ChangeNotifier {
  final _planetsService = KiwiContainer().resolve<PlanetsService>();
  final _peopleService = KiwiContainer().resolve<PeopleService>();
  final _filmsService = KiwiContainer().resolve<FilmsService>();

  final Specie specie;

  Planet? get homeworld => _planetsService.getPlanet(url: specie.homeworld);
  List<Person> get people => _peopleService.getPeople(urls: specie.people);
  List<Film> get films => _filmsService.getFilms(urls: specie.films);

  SpecieDetailsProvider(this.specie);
}
