import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/services/starships_service.dart';

class StarshipsProvider extends ChangeNotifier {
  final _starshipsService = KiwiContainer().resolve<StarshipsService>();

  final List<Starship> _starships = [];

  late Fuzzy<Starship> _fuse;

  List<Starship> get starships => _starships;

  StarshipsProvider() {
    _starships.addAll(_starshipsService.starships);
    _fuse = Fuzzy(
      _starshipsService.starships,
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
          WeightedKey<Starship>(
            getter: (starship) => starship.name ?? '',
            name: 'name',
            weight: 50,
          ),
          WeightedKey<Starship>(
            getter: (starship) => starship.starshipClass ?? '',
            name: 'starshipClass',
            weight: 50,
          ),
          WeightedKey<Starship>(
            getter: (starship) => starship.model ?? '',
            name: 'model',
            weight: 50,
          ),
        ],
      ),
    );
  }

  void search(String text) {
    _starships.clear();
    final result = _fuse.search(text);
    for (var r in result) {
      _starships.add(r.item);
    }
    notifyListeners();
  }
}
