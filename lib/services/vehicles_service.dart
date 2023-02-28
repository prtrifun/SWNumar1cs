import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/services/api_service.dart';

class VehiclesService {
  static const _url = 'https://swapi.dev/api/starships';

  final List<Vehicle> _vehicles = [];

  List<Vehicle> get vehicles => List.unmodifiable(_vehicles);

  VehiclesService() {
    fetchSpecies(_url);
  }

  void fetchSpecies(String url) async {
    final vehicles = await KiwiContainer().resolve<ApiService>().fetchData(_url);
    for (Map<String, dynamic> vehicle in vehicles) {
      _vehicles.add(Vehicle.fromJson(vehicle));
    }
  }
}
