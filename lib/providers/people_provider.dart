import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/services/people_service.dart';

class PeopleProvider extends ChangeNotifier {
  final _peopleService = KiwiContainer().resolve<PeopleService>();

  final List<Person> _people = [];

  late Fuzzy<Person> _fuse;

  List<Person> get people => _people;

  PeopleProvider() {
    _people.addAll(_peopleService.people);
    _fuse = Fuzzy(
      _peopleService.people,
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
          WeightedKey<Person>(
            getter: (person) => person.name ?? '',
            name: 'name',
            weight: 50,
          ),
          WeightedKey<Person>(
            getter: (person) => person.height ?? '',
            name: 'height',
            weight: 50,
          ),
          WeightedKey<Person>(
            getter: (person) => person.birthYear ?? '',
            name: 'birthYear',
            weight: 50,
          ),
        ],
      ),
    );
  }

  void search(String text) {
    _people.clear();
    final result = _fuse.search(text);
    for (var r in result) {
      _people.add(r.item);
    }
    notifyListeners();
  }
}
