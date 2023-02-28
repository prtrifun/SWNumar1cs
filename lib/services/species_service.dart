import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/services/api_service.dart';
import 'package:swnumar1cs/services/local_data_service.dart';

class SpeciesService {
  final _localDataService = KiwiContainer().resolve<LocalDataService>();

  final List<Specie> _species = [];

  List<Specie> get species => List.unmodifiable(_species);

  SpeciesService() {
    _fetchSpecies();
  }

  void _fetchSpecies() async {
    final localData = await _localDataService.readLocalJson(kSpecies);
    if (localData != null) {
      _loadSpecies(localData);
    } else {
      final species = await KiwiContainer().resolve<ApiService>().fetchData(kBaseURL + kSpecies);
      _localDataService.saveLocalJson(kSpecies, species);
      _loadSpecies(species);
    }
  }

  void _loadSpecies(List<dynamic> species) {
    for (Map<String, dynamic> specie in species) {
      _species.add(Specie.fromJson(specie));
    }
  }
}
