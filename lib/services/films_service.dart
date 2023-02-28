import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/services/api_service.dart';

class FilmsService {
  static const _url = 'https://swapi.dev/api/films';

  final List<Film> _films = [];

  List<Film> get films => List.unmodifiable(_films);

  FilmsService() {
    fetchFilms(_url);
  }

  void fetchFilms(String url) async {
    final films = await KiwiContainer().resolve<ApiService>().fetchData(_url);
    for (Map<String, dynamic> film in films) {
      _films.add(Film.fromJson(film));
    }
  }
}
