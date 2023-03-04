import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/mixins/subscription_mixin.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/services/api_service.dart';
import 'package:swnumar1cs/services/local_data_service.dart';
import 'package:collection/collection.dart';

enum StarshipsServiceEvent { loading, ready, error }

class StarshipsService with SubscriptionMixin<StarshipsServiceEvent> {
  final _localDataService = KiwiContainer().resolve<LocalDataService>();

  final List<Starship> _starships = [];
  StarshipsServiceEvent _event = StarshipsServiceEvent.loading;

  List<Starship> get starships => List.unmodifiable(_starships);
  StarshipsServiceEvent get event => _event;

  StarshipsService() {
    fetchStarships();
  }

  void fetchStarships() async {
    _sendEvent(StarshipsServiceEvent.loading);
    try {
      final localData = await _localDataService.readLocalJson(kStarships);
      if (localData != null) {
        _loadStarships(localData);
      } else {
        final starships = await KiwiContainer().resolve<ApiService>().fetchData(kBaseURL + kStarships);
        _localDataService.saveLocalJson(kStarships, starships);
        _loadStarships(starships);
      }
    } catch (e) {
      _sendEvent(StarshipsServiceEvent.error);
    }
  }

  void _loadStarships(List<dynamic> starships) {
    for (Map<String, dynamic> starship in starships) {
      _starships.add(Starship.fromJson(starship));
    }
    _sendEvent(StarshipsServiceEvent.ready);
  }

  Starship? _getStarship({String? url}) {
    return _starships.firstWhereOrNull((element) => element.url == url);
  }

  List<Starship> getStarships({required List<String?> urls}) {
    final List<Starship> starships = [];
    for (String? url in urls) {
      final starship = _getStarship(url: url);
      if (starship != null) {
        starships.add(starship);
      }
    }
    return starships;
  }

  void _sendEvent(StarshipsServiceEvent event) {
    _event = event;
    sendEvent(event);
  }
}
