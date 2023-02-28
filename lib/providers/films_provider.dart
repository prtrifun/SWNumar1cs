import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/services/films_service.dart';

class FilmsProvider extends ChangeNotifier {
  final _filmsService = KiwiContainer().resolve<FilmsService>();

  List<Film> get films => List.unmodifiable(_filmsService.films);
}
