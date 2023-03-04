import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/services/species_service.dart';

class SpeciesProvider extends ChangeNotifier {
  final _speciesService = KiwiContainer().resolve<SpeciesService>();

  final List<Specie> _species = [];

  late Fuzzy<Specie> _fuse;

  List<Specie> get species => _species;
  SpeciesServiceEvent get event => _speciesService.event;

  SpeciesProvider() {
    if (event == SpeciesServiceEvent.ready) {
      _initFuse();
    } else {
      _speciesService.subscribe(_listenToSpeciesService);
    }
  }

  @override
  void dispose() {
    _speciesService.unsubscribe(_listenToSpeciesService);
    super.dispose();
  }

  void _initFuse() {
    _species.addAll(_speciesService.species);
    _fuse = Fuzzy(
      _speciesService.species,
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
          WeightedKey<Specie>(
            getter: (specie) => specie.name ?? '',
            name: 'name',
            weight: 50,
          ),
          WeightedKey<Specie>(
            getter: (specie) => specie.classification ?? '',
            name: 'classification',
            weight: 50,
          ),
          WeightedKey<Specie>(
            getter: (specie) => specie.language ?? '',
            name: 'language',
            weight: 50,
          ),
        ],
      ),
    );
  }

  void _listenToSpeciesService(SpeciesServiceEvent event, List<dynamic> params) {
    switch (event) {
      case SpeciesServiceEvent.loading:
        // display loading indicator
        break;
      case SpeciesServiceEvent.ready:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _speciesService.unsubscribe(_listenToSpeciesService);
        });
        _initFuse();
        break;
      case SpeciesServiceEvent.error:
        // display error message
        break;
    }
    notifyListeners();
  }

  void search(String text) {
    _species.clear();
    final result = _fuse.search(text);
    for (var r in result) {
      _species.add(r.item);
    }
    notifyListeners();
  }

  void tryAgain() {
    _speciesService.fetchSpecies();
  }
}
