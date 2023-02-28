import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/services/api_service.dart';
import 'package:swnumar1cs/services/local_data_service.dart';

class PlanetsService {
  final _localDataService = KiwiContainer().resolve<LocalDataService>();

  final List<Planet> _planets = [];

  List<Planet> get planets => List.unmodifiable(_planets);

  PlanetsService() {
    _fetchPlanets();
  }

  void _fetchPlanets() async {
    final localData = await _localDataService.readLocalJson(kPlanets);
    if (localData != null) {
      _loadPlanets(localData);
    } else {
      final planets = await KiwiContainer().resolve<ApiService>().fetchData(kBaseURL + kPlanets);
      _localDataService.saveLocalJson(kPlanets, planets);
      _loadPlanets(planets);
    }
  }

  void _loadPlanets(List<dynamic> planets) {
    for (Map<String, dynamic> planet in planets) {
      _planets.add(Planet.fromJson(planet));
    }
  }
}
