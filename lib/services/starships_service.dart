import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/services/api_service.dart';
import 'package:swnumar1cs/services/local_data_service.dart';

class StarshipsService {
  final _localDataService = KiwiContainer().resolve<LocalDataService>();

  final List<Starship> _starships = [];

  List<Starship> get starships => List.unmodifiable(_starships);

  StarshipsService() {
    _fetchStarships();
  }

  void _fetchStarships() async {
    final localData = await _localDataService.readLocalJson(kStarships);
    if (localData != null) {
      _loadStarships(localData);
    } else {
      final starships = await KiwiContainer().resolve<ApiService>().fetchData(kBaseURL + kStarships);
      _localDataService.saveLocalJson(kStarships, starships);
      _loadStarships(starships);
    }
  }

  void _loadStarships(List<dynamic> starships) {
    for (Map<String, dynamic> starship in starships) {
      _starships.add(Starship.fromJson(starship));
    }
  }
}
