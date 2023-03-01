import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/services/films_service.dart';
import 'package:swnumar1cs/services/people_service.dart';

class VehicleDetailsProvider extends ChangeNotifier {
  final _peopleService = KiwiContainer().resolve<PeopleService>();
  final _filmsService = KiwiContainer().resolve<FilmsService>();

  final Vehicle vehicle;

  List<Person> get pilots => _peopleService.getPeople(urls: vehicle.pilots);
  List<Film> get films => _filmsService.getFilms(urls: vehicle.films);

  VehicleDetailsProvider(this.vehicle);
}
