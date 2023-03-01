import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/services/api_service.dart';
import 'package:swnumar1cs/services/local_data_service.dart';
import 'package:collection/collection.dart';

class FilmsService {
  final _localDataService = KiwiContainer().resolve<LocalDataService>();

  final List<Film> _films = [];

  List<Film> get films => List.unmodifiable(_films);

  FilmsService() {
    _fetchFilms();
  }

  void _fetchFilms() async {
    final localData = await _localDataService.readLocalJson(kFilms);
    if (localData != null) {
      _loadFilms(localData);
    } else {
      final films = await KiwiContainer().resolve<ApiService>().fetchData(kBaseURL + kFilms);
      _localDataService.saveLocalJson(kFilms, films);
      _loadFilms(films);
    }
  }

  void _loadFilms(List<dynamic> films) {
    for (Map<String, dynamic> film in films) {
      _films.add(Film.fromJson(film));
    }
  }

  Film? _getFilm({String? url}) {
    return _films.firstWhereOrNull((element) => element.url == url);
  }

  List<Film> getFilms({required List<String?> urls}) {
    final List<Film> films = [];
    for (String? url in urls) {
      final film = _getFilm(url: url);
      if (film != null) {
        films.add(film);
      }
    }
    return films;
  }
}
