import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/services/api_service.dart';

class StarshipsService {
  static const _url = 'https://swapi.dev/api/starships';

  final List<Starship> _starships = [];

  List<Starship> get starships => List.unmodifiable(_starships);

  StarshipsService() {
    fetchSpecies(_url);
  }

  void fetchSpecies(String url) async {
    final starships = await KiwiContainer().resolve<ApiService>().fetchData(_url);
    for (Map<String, dynamic> starship in starships) {
      _starships.add(Starship.fromJson(starship));
    }
  }
}
