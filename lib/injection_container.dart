import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/services/api_service.dart';
import 'package:swnumar1cs/services/films_service.dart';
import 'package:swnumar1cs/services/local_data_service.dart';
import 'package:swnumar1cs/services/people_service.dart';
import 'package:swnumar1cs/services/planets_service.dart';
import 'package:swnumar1cs/services/router_service.dart';
import 'package:swnumar1cs/services/species_service.dart';
import 'package:swnumar1cs/services/starships_service.dart';
import 'package:swnumar1cs/services/vehicles_service.dart';

void initKiwi() {
  KiwiContainer().registerFactory((s) => ApiService());
  KiwiContainer().registerFactory((s) => LocalDataService());
  KiwiContainer().registerSingleton((s) => RouterService());
  KiwiContainer().registerSingleton((s) => FilmsService());
  KiwiContainer().registerSingleton((s) => PeopleService());
  KiwiContainer().registerSingleton((s) => PlanetsService());
  KiwiContainer().registerSingleton((s) => SpeciesService());
  KiwiContainer().registerSingleton((s) => StarshipsService());
  KiwiContainer().registerSingleton((s) => VehiclesService());
}
