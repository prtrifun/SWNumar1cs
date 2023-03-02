import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/services/api_service.dart';
import 'package:swnumar1cs/services/local_data_service.dart';
import 'package:collection/collection.dart';

class PeopleService {
  final _localDataService = KiwiContainer().resolve<LocalDataService>();

  final List<Person> _people = [];

  List<Person> get people => List.unmodifiable(_people);

  Future<void> init() async {
    await _fetchPeople();
  }

  Future<void> _fetchPeople() async {
    final localData = await _localDataService.readLocalJson(kPeople);
    if (localData != null) {
      _loadPeople(localData);
    } else {
      final people = await KiwiContainer().resolve<ApiService>().fetchData(kBaseURL + kPeople);
      _localDataService.saveLocalJson(kPeople, people);
      _loadPeople(people);
    }
  }

  void _loadPeople(List<dynamic> people) {
    for (Map<String, dynamic> person in people) {
      _people.add(Person.fromJson(person));
    }
  }

  Person? _getPerson({String? url}) {
    return _people.firstWhereOrNull((element) => element.url == url);
  }

  List<Person> getPeople({required List<String?> urls}) {
    final List<Person> people = [];
    for (String? url in urls) {
      final person = _getPerson(url: url);
      if (person != null) {
        people.add(person);
      }
    }
    return people;
  }
}
