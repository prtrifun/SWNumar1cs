import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/services/people_service.dart';
import 'package:swnumar1cs/services/planets_service.dart';
import 'package:swnumar1cs/services/species_service.dart';

class SpeciesProvider extends ChangeNotifier {
  final _speciesService = KiwiContainer().resolve<SpeciesService>();

  final List<Specie> _species = [];

  late Fuzzy<Specie> _fuse;

  List<Specie> get species => _species;

  SpeciesProvider() {
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

  void search(String text) {
    _species.clear();
    final result = _fuse.search(text);
    for (var r in result) {
      _species.add(r.item);
    }
    notifyListeners();
  }
}
