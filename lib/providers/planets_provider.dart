import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/services/planets_service.dart';

class PlanetsProvider extends ChangeNotifier {
  final _planetsService = KiwiContainer().resolve<PlanetsService>();

  final List<Planet> _planets = [];

  late Fuzzy<Planet> _fuse;

  List<Planet> get planets => _planets;
  PlanetsServiceEvent get event => _planetsService.event;

  PlanetsProvider() {
    if (event == PlanetsServiceEvent.ready) {
      _initFuse();
    } else {
      _planetsService.subscribe(_listenToPlanetsService);
    }
  }

  @override
  void dispose() {
    _planetsService.unsubscribe(_listenToPlanetsService);
    super.dispose();
  }

  void _initFuse() {
    _planets.addAll(_planetsService.planets);
    _fuse = Fuzzy(
      _planetsService.planets,
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
          WeightedKey<Planet>(
            getter: (planet) => planet.name ?? '',
            name: 'name',
            weight: 50,
          ),
          WeightedKey<Planet>(
            getter: (planet) => planet.population ?? '',
            name: 'population',
            weight: 50,
          ),
          WeightedKey<Planet>(
            getter: (planet) => planet.terrain ?? '',
            name: 'terrain',
            weight: 50,
          ),
        ],
      ),
    );
  }

  void _listenToPlanetsService(PlanetsServiceEvent event, List<dynamic> params) {
    switch (event) {
      case PlanetsServiceEvent.loading:
        // display loading indicator
        break;
      case PlanetsServiceEvent.ready:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _planetsService.unsubscribe(_listenToPlanetsService);
        });
        _initFuse();
        break;
      case PlanetsServiceEvent.error:
        // display error message
        break;
    }
    notifyListeners();
  }

  void search(String text) {
    _planets.clear();
    final result = _fuse.search(text);
    for (var r in result) {
      _planets.add(r.item);
    }
    notifyListeners();
  }

  void tryAgain() {
    _planetsService.fetchPlanets();
  }
}
