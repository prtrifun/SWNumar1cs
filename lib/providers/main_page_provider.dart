import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:kiwi/kiwi.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/models/resource.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/services/films_service.dart';
import 'package:swnumar1cs/services/people_service.dart';
import 'package:swnumar1cs/services/planets_service.dart';
import 'package:swnumar1cs/services/species_service.dart';
import 'package:swnumar1cs/services/starships_service.dart';
import 'package:swnumar1cs/services/vehicles_service.dart';

enum MainPageState { loading, ready, error }

enum Filter { films, people, planets, species, starships, vehicles }

class MainPageProvider extends ChangeNotifier {
  final _filmsService = KiwiContainer().resolve<FilmsService>();
  final _peopleService = KiwiContainer().resolve<PeopleService>();
  final _planetsService = KiwiContainer().resolve<PlanetsService>();
  final _speciesService = KiwiContainer().resolve<SpeciesService>();
  final _starshipsService = KiwiContainer().resolve<StarshipsService>();
  final _vehiclesService = KiwiContainer().resolve<VehiclesService>();

  Fuzzy<Resource>? _fuse;

  final List<Resource> _resources = [];
  final List<Resource> _filteredResources = [];

  final List<Filter> _activeFilters = [
    Filter.films,
    Filter.people,
    Filter.planets,
    Filter.species,
    Filter.starships,
    Filter.vehicles
  ];

  String _searchText = '';

  List<Resource> get resources => _filteredResources;
  List<Filter> get activeFilters => _activeFilters;

  MainPageState get state {
    if (_filmsService.event == FilmServiceEvent.loading ||
        _peopleService.event == PeopleServiceEvent.loading ||
        _planetsService.event == PlanetsServiceEvent.loading ||
        _speciesService.event == SpeciesServiceEvent.loading ||
        _starshipsService.event == StarshipsServiceEvent.loading ||
        _vehiclesService.event == VehiclesServiceEvent.loading) {
      return MainPageState.loading;
    } else if (_filmsService.event == FilmServiceEvent.error ||
        _peopleService.event == PeopleServiceEvent.error ||
        _planetsService.event == PlanetsServiceEvent.error ||
        _speciesService.event == SpeciesServiceEvent.error ||
        _starshipsService.event == StarshipsServiceEvent.error ||
        _vehiclesService.event == VehiclesServiceEvent.error) {
      return MainPageState.error;
    } else {
      return MainPageState.ready;
    }
  }

  MainPageProvider() {
    _getResources();
  }

  @override
  void dispose() {
    _filmsService.unsubscribe(_listenToFilmsService);
    _peopleService.unsubscribe(_listenToPeopleService);
    _planetsService.unsubscribe(_listenToPlanetsService);
    _speciesService.unsubscribe(_listenToSpeciesService);
    _starshipsService.unsubscribe(_listenToStarshipsService);
    _vehiclesService.unsubscribe(_listenToVehiclesService);

    super.dispose();
  }

  void _getResources() {
    if (_filmsService.event == FilmServiceEvent.ready) {
      _resources.addAll(_filmsService.films);
    } else {
      _filmsService.subscribe(_listenToFilmsService);
    }

    if (_peopleService.event == PeopleServiceEvent.ready) {
      _resources.addAll(_peopleService.people);
    } else {
      _peopleService.subscribe(_listenToPeopleService);
    }

    if (_planetsService.event == PlanetsServiceEvent.ready) {
      _resources.addAll(_planetsService.planets);
    } else {
      _planetsService.subscribe(_listenToPlanetsService);
    }

    if (_speciesService.event == SpeciesServiceEvent.ready) {
      _resources.addAll(_planetsService.planets);
    } else {
      _speciesService.subscribe(_listenToSpeciesService);
    }

    if (_starshipsService.event == StarshipsServiceEvent.ready) {
      _resources.addAll(_starshipsService.starships);
    } else {
      _starshipsService.subscribe(_listenToStarshipsService);
    }

    if (_vehiclesService.event == VehiclesServiceEvent.ready) {
      _resources.addAll(_vehiclesService.vehicles);
    } else {
      _vehiclesService.subscribe(_listenToVehiclesService);
    }
  }

  void _initFuse() {
    if (state == MainPageState.ready) {
      _filteredResources.clear();
      _filteredResources.addAll(_resources);
      for (Filter filter in Filter.values) {
        _filteredResources.removeWhere((element) {
          switch (filter) {
            case Filter.films:
              if (!_activeFilters.contains(filter)) {
                return element is Film;
              }
              break;
            case Filter.people:
              if (!_activeFilters.contains(filter)) {
                return element is Person;
              }
              break;
            case Filter.planets:
              if (!_activeFilters.contains(filter)) {
                return element is Planet;
              }
              break;
            case Filter.species:
              if (!_activeFilters.contains(filter)) {
                return element is Specie;
              }
              break;
            case Filter.starships:
              if (!_activeFilters.contains(filter)) {
                return element is Starship;
              }
              break;
            case Filter.vehicles:
              if (!_activeFilters.contains(filter)) {
                return element is Vehicle;
              }
              break;
          }
          return false;
        });
      }
      _fuse = Fuzzy(
        [..._filteredResources],
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
            WeightedKey<Resource>(
              getter: (resource) => resource.getWeightedKey1(),
              name: 'WK1',
              weight: 50,
            ),
            WeightedKey<Resource>(
              getter: (resource) => resource.getWeightedKey2(),
              name: 'WK2',
              weight: 50,
            ),
            WeightedKey<Resource>(
              getter: (resource) => resource.getWeightedKey3(),
              name: 'WK3',
              weight: 50,
            ),
          ],
        ),
      );
      if (_searchText.isNotEmpty) {
        search(_searchText);
      }
    }
    notifyListeners();
  }

  void _listenToFilmsService(FilmServiceEvent event, List<dynamic> params) {
    switch (event) {
      case FilmServiceEvent.loading:
        // display loading indicator
        break;
      case FilmServiceEvent.ready:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _filmsService.unsubscribe(_listenToFilmsService);
        });
        _resources.addAll(_filmsService.films);
        break;
      case FilmServiceEvent.error:
        // display error message
        break;
    }
    _initFuse();
  }

  void _listenToPeopleService(PeopleServiceEvent event, List<dynamic> params) {
    switch (event) {
      case PeopleServiceEvent.loading:
        // display loading indicator
        break;
      case PeopleServiceEvent.ready:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _peopleService.unsubscribe(_listenToPeopleService);
        });
        _resources.addAll(_peopleService.people);
        break;
      case PeopleServiceEvent.error:
        // display error message
        break;
    }
    _initFuse();
  }

  void _listenToPlanetsService(PlanetsServiceEvent event, List<dynamic> params) {
    switch (event) {
      case PlanetsServiceEvent.loading:
        // display loading indicator
        break;
      case PlanetsServiceEvent.ready:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _planetsService.unsubscribe(_listenToPlanetsService);
        });
        _resources.addAll(_planetsService.planets);
        break;
      case PlanetsServiceEvent.error:
        // display error message
        break;
    }
    _initFuse();
  }

  void _listenToSpeciesService(SpeciesServiceEvent event, List<dynamic> params) {
    switch (event) {
      case SpeciesServiceEvent.loading:
        // display loading indicator
        break;
      case SpeciesServiceEvent.ready:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _speciesService.unsubscribe(_listenToSpeciesService);
        });
        _resources.addAll(_speciesService.species);
        break;
      case SpeciesServiceEvent.error:
        // display error message
        break;
    }
    _initFuse();
  }

  void _listenToStarshipsService(StarshipsServiceEvent event, List<dynamic> params) {
    switch (event) {
      case StarshipsServiceEvent.loading:
        // display loading indicator
        break;
      case StarshipsServiceEvent.ready:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _starshipsService.unsubscribe(_listenToStarshipsService);
        });
        _resources.addAll(_starshipsService.starships);
        break;
      case StarshipsServiceEvent.error:
        // display error message
        break;
    }
    _initFuse();
  }

  void _listenToVehiclesService(VehiclesServiceEvent event, List<dynamic> params) {
    switch (event) {
      case VehiclesServiceEvent.loading:
        // display loading indicator
        break;
      case VehiclesServiceEvent.ready:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _vehiclesService.unsubscribe(_listenToVehiclesService);
        });
        _resources.addAll(_vehiclesService.vehicles);
        break;
      case VehiclesServiceEvent.error:
        // display error message
        break;
    }
    _initFuse();
  }

  void search(String text) {
    _searchText = text;
    _filteredResources.clear();
    if (_fuse != null) {
      final result = _fuse!.search(text);
      for (var r in result) {
        _filteredResources.add(r.item);
      }
      notifyListeners();
    }
  }

  void tryAgain() {
    if (_filmsService.event == FilmServiceEvent.error) {
      _filmsService.fetchFilms();
    }

    if (_peopleService.event == PeopleServiceEvent.error) {
      _peopleService.fetchPeople();
    }

    if (_planetsService.event == PlanetsServiceEvent.error) {
      _planetsService.fetchPlanets();
    }

    if (_speciesService.event == SpeciesServiceEvent.error) {
      _speciesService.fetchSpecies();
    }

    if (_starshipsService.event == StarshipsServiceEvent.error) {
      _starshipsService.fetchStarships();
    }

    if (_vehiclesService.event == VehiclesServiceEvent.error) {
      _vehiclesService.fetchVehicles();
    }
  }

  void toggleFilter(Filter filter) {
    if (_activeFilters.contains(filter)) {
      _activeFilters.remove(filter);
    } else {
      _activeFilters.add(filter);
    }
    _initFuse();
    notifyListeners();
  }
}
