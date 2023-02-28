import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/services/api_service.dart';

class PeopleService {
  static const _url = 'https://swapi.dev/api/people';

  final List<Person> _people = [];

  List<Person> get people => List.unmodifiable(_people);

  PeopleService() {
    fetchPeople(_url);
  }

  void fetchPeople(String url) async {
    final people = await KiwiContainer().resolve<ApiService>().fetchData(_url);
    for (Map<String, dynamic> person in people) {
      _people.add(Person.fromJson(person));
    }
  }
}
