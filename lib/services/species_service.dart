import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/services/api_service.dart';

class SpeciesService {
  static const _url = 'https://swapi.dev/api/species';

  final List<Specie> _species = [];

  List<Specie> get species => List.unmodifiable(_species);

  SpeciesService() {
    fetchSpecies(_url);
  }

  void fetchSpecies(String url) async {
    final species = await KiwiContainer().resolve<ApiService>().fetchData(_url);
    for (Map<String, dynamic> specie in species) {
      _species.add(Specie.fromJson(specie));
    }
  }
}
