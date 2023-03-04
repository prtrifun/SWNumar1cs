import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/mixins/subscription_mixin.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/services/api_service.dart';
import 'package:swnumar1cs/services/local_data_service.dart';
import 'package:collection/collection.dart';

enum SpeciesServiceEvent { loading, ready, error }

class SpeciesService with SubscriptionMixin<SpeciesServiceEvent> {
  final _localDataService = KiwiContainer().resolve<LocalDataService>();

  final List<Specie> _species = [];
  SpeciesServiceEvent _event = SpeciesServiceEvent.loading;

  List<Specie> get species => List.unmodifiable(_species);
  SpeciesServiceEvent get event => _event;

  SpeciesService() {
    fetchSpecies();
  }

  void fetchSpecies() async {
    _sendEvent(SpeciesServiceEvent.loading);
    try {
      final localData = await _localDataService.readLocalJson(kSpecies);
      if (localData != null) {
        _loadSpecies(localData);
      } else {
        final species = await KiwiContainer().resolve<ApiService>().fetchData(kBaseURL + kSpecies);
        _localDataService.saveLocalJson(kSpecies, species);
        _loadSpecies(species);
      }
    } catch (e) {
      _sendEvent(SpeciesServiceEvent.error);
    }
  }

  void _loadSpecies(List<dynamic> species) {
    for (Map<String, dynamic> specie in species) {
      _species.add(Specie.fromJson(specie));
    }
    _sendEvent(SpeciesServiceEvent.ready);
  }

  Specie? _getSpecie({String? url}) {
    return _species.firstWhereOrNull((element) => element.url == url);
  }

  List<Specie> getSpecies({required List<String?> urls}) {
    final List<Specie> species = [];
    for (String? url in urls) {
      final specie = _getSpecie(url: url);
      if (specie != null) {
        species.add(specie);
      }
    }
    return species;
  }

  void _sendEvent(SpeciesServiceEvent event) {
    _event = event;
    sendEvent(event);
  }
}
