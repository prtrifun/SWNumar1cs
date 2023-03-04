import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/mixins/subscription_mixin.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/services/api_service.dart';
import 'package:swnumar1cs/services/local_data_service.dart';
import 'package:collection/collection.dart';

enum PlanetsServiceEvent { loading, ready, error }

class PlanetsService with SubscriptionMixin<PlanetsServiceEvent> {
  final _localDataService = KiwiContainer().resolve<LocalDataService>();

  final List<Planet> _planets = [];
  PlanetsServiceEvent _event = PlanetsServiceEvent.loading;

  List<Planet> get planets => List.unmodifiable(_planets);
  PlanetsServiceEvent get event => _event;

  PlanetsService() {
    fetchPlanets();
  }

  void fetchPlanets() async {
    _sendEvent(PlanetsServiceEvent.loading);
    try {
      final localData = await _localDataService.readLocalJson(kPlanets);
      if (localData != null) {
        _loadPlanets(localData);
      } else {
        final planets = await KiwiContainer().resolve<ApiService>().fetchData(kBaseURL + kPlanets);
        _localDataService.saveLocalJson(kPlanets, planets);
        _loadPlanets(planets);
      }
    } catch (e) {
      _sendEvent(PlanetsServiceEvent.error);
    }
  }

  void _loadPlanets(List<dynamic> planets) {
    for (Map<String, dynamic> planet in planets) {
      _planets.add(Planet.fromJson(planet));
    }
    _sendEvent(PlanetsServiceEvent.ready);
  }

  Planet? getPlanet({String? url}) {
    return _planets.firstWhereOrNull((element) => element.url == url);
  }

  List<Planet> getPlanets({required List<String?> urls}) {
    final List<Planet> planets = [];
    for (String? url in urls) {
      final planet = getPlanet(url: url);
      if (planet != null) {
        planets.add(planet);
      }
    }
    return planets;
  }

  void _sendEvent(PlanetsServiceEvent event) {
    _event = event;
    sendEvent(event);
  }
}
