import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/services/api_service.dart';

class PlanetsService {
  static const _url = 'https://swapi.dev/api/planets';

  final List<Planet> _planets = [];

  List<Planet> get planets => List.unmodifiable(_planets);

  PlanetsService() {
    fetchPlanets(_url);
  }

  void fetchPlanets(String url) async {
    final planets = await KiwiContainer().resolve<ApiService>().fetchData(_url);
    for (Map<String, dynamic> planet in planets) {
      _planets.add(Planet.fromJson(planet));
    }
  }
}
