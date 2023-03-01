import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/services/vehicles_service.dart';

class VehiclesProvider extends ChangeNotifier {
  final _vehiclesService = KiwiContainer().resolve<VehiclesService>();

  final List<Vehicle> _vehicles = [];

  late Fuzzy<Vehicle> _fuse;

  List<Vehicle> get vehicle => _vehicles;

  VehiclesProvider() {
    _vehicles.addAll(_vehiclesService.vehicles);
    _fuse = Fuzzy(
      _vehiclesService.vehicles,
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
          WeightedKey<Vehicle>(
            getter: (vehicle) => vehicle.name ?? '',
            name: 'name',
            weight: 50,
          ),
          WeightedKey<Vehicle>(
            getter: (vehicle) => vehicle.manufacturer ?? '',
            name: 'manufacturer',
            weight: 50,
          ),
          WeightedKey<Vehicle>(
            getter: (vehicle) => vehicle.model ?? '',
            name: 'model',
            weight: 50,
          ),
        ],
      ),
    );
  }

  void search(String text) {
    _vehicles.clear();
    final result = _fuse.search(text);
    for (var r in result) {
      _vehicles.add(r.item);
    }
    notifyListeners();
  }
}
