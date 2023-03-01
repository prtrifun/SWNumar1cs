import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/services/films_service.dart';
import 'package:swnumar1cs/services/people_service.dart';

class StarshipDetailsProvider extends ChangeNotifier {
  final _peopleService = KiwiContainer().resolve<PeopleService>();
  final _filmsService = KiwiContainer().resolve<FilmsService>();

  final Starship starship;

  List<Person> get pilots => _peopleService.getPeople(urls: starship.pilots);
  List<Film> get films => _filmsService.getFilms(urls: starship.films);

  StarshipDetailsProvider(this.starship);
}
