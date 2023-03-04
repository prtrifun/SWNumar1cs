import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/services/films_service.dart';

class FilmsProvider extends ChangeNotifier {
  final _filmsService = KiwiContainer().resolve<FilmsService>();

  final List<Film> _films = [];

  late Fuzzy<Film> _fuse;

  List<Film> get films => _films;
  FilmServiceEvent get event => _filmsService.event;

  FilmsProvider() {
    if (event == FilmServiceEvent.ready) {
      _initFuse();
    } else {
      _filmsService.subscribe(_listenToFilmsService);
    }
  }

  @override
  void dispose() {
    _filmsService.unsubscribe(_listenToFilmsService);
    super.dispose();
  }

  void _initFuse() {
    _films.addAll(_filmsService.films);
    _fuse = Fuzzy(
      _filmsService.films,
      options: FuzzyOptions(
        isCaseSensitive: false,
        matchAllTokens: false,
        shouldSort: true,
        findAllMatches: false,
        tokenize: true,
        shouldNormalize: true,
        minMatchCharLength: 2,
        minTokenCharLength: 2,
        location: 0,
        threshold: 0.3,
        distance: 80,
        keys: [
          WeightedKey<Film>(
            getter: (film) => film.title ?? '',
            name: 'title',
            weight: 50,
          ),
          WeightedKey<Film>(
            getter: (film) => film.director ?? '',
            name: 'director',
            weight: 50,
          ),
          WeightedKey<Film>(
            getter: (film) => film.producer ?? '',
            name: 'producer',
            weight: 50,
          ),
        ],
      ),
    );
  }

  void _listenToFilmsService(FilmServiceEvent event, List<dynamic> params) {
    switch (event) {
      case FilmServiceEvent.loading:
        // display loading indicator
        break;
      case FilmServiceEvent.ready:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _filmsService.unsubscribe(_listenToFilmsService);
        });
        _initFuse();
        break;
      case FilmServiceEvent.error:
        // display error message
        break;
    }
    notifyListeners();
  }

  void search(String text) {
    _films.clear();
    final result = _fuse.search(text);
    for (var r in result) {
      _films.add(r.item);
    }
    notifyListeners();
  }

  void tryAgain() {
    _filmsService.fetchFilms();
  }
}
