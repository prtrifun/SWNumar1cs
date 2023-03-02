import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/services/api_service.dart';
import 'package:swnumar1cs/services/local_data_service.dart';
import 'package:collection/collection.dart';

class VehiclesService {
  final _localDataService = KiwiContainer().resolve<LocalDataService>();

  final List<Vehicle> _vehicles = [];

  List<Vehicle> get vehicles => List.unmodifiable(_vehicles);

  Future<void> init() async {
    await _fetchVehicles();
  }

  Future<void> _fetchVehicles() async {
    final localData = await _localDataService.readLocalJson(kVehicles);
    if (localData != null) {
      _loadVehicles(localData);
    } else {
      final vehicles = await KiwiContainer().resolve<ApiService>().fetchData(kBaseURL + kVehicles);
      _localDataService.saveLocalJson(kVehicles, vehicles);
      _loadVehicles(vehicles);
    }
  }

  void _loadVehicles(List<dynamic> vehicles) {
    for (Map<String, dynamic> vehicle in vehicles) {
      _vehicles.add(Vehicle.fromJson(vehicle));
    }
  }

  Vehicle? _getVehicle({String? url}) {
    return _vehicles.firstWhereOrNull((element) => element.url == url);
  }

  List<Vehicle> getVehicles({required List<String?> urls}) {
    final List<Vehicle> vehicles = [];
    for (String? url in urls) {
      final vehicle = _getVehicle(url: url);
      if (vehicle != null) {
        vehicles.add(vehicle);
      }
    }
    return vehicles;
  }
}
