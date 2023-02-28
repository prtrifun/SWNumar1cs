import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/services/api_service.dart';
import 'package:swnumar1cs/services/films_service.dart';
import 'package:swnumar1cs/services/people_service.dart';

void initKiwi() {
  KiwiContainer().registerFactory((s) => ApiService());
  KiwiContainer().registerSingleton((s) => FilmsService());
  KiwiContainer().registerSingleton((s) => PeopleService());
}
