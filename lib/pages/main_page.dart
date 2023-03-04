import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';
import 'package:swnumar1cs/models/planet.dart';
import 'package:swnumar1cs/models/specie.dart';
import 'package:swnumar1cs/models/starship.dart';
import 'package:swnumar1cs/models/vehicle.dart';
import 'package:swnumar1cs/pages/film_details.dart';
import 'package:swnumar1cs/pages/person_details.dart';
import 'package:swnumar1cs/pages/planet_details.dart';
import 'package:swnumar1cs/pages/specie_details.dart';
import 'package:swnumar1cs/pages/starship_details.dart';
import 'package:swnumar1cs/pages/vehicle_details.dart';
import 'package:swnumar1cs/providers/main_page_provider.dart';
import 'package:swnumar1cs/widgets/cell.dart';
import 'package:swnumar1cs/widgets/custom_error_widget.dart';
import 'package:swnumar1cs/widgets/filter_widget.dart';
import 'package:swnumar1cs/widgets/loading.dart';

class MainPage extends StatelessWidget {
  static const pageName = 'mainPage';

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainPageProvider>(
      create: (context) => MainPageProvider(),
      child: Consumer<MainPageProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              title: Text('app_title'.tr()),
            ),
            drawer: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  FilterWidget(
                    onPressed: () => provider.toggleFilter(Filter.films),
                    title: 'films'.tr(),
                    active: provider.activeFilters.contains(Filter.films),
                  ),
                  FilterWidget(
                    onPressed: () => provider.toggleFilter(Filter.people),
                    title: 'people'.tr(),
                    active: provider.activeFilters.contains(Filter.people),
                  ),
                  FilterWidget(
                    onPressed: () => provider.toggleFilter(Filter.planets),
                    title: 'planets'.tr(),
                    active: provider.activeFilters.contains(Filter.planets),
                  ),
                  FilterWidget(
                    onPressed: () => provider.toggleFilter(Filter.species),
                    title: 'species'.tr(),
                    active: provider.activeFilters.contains(Filter.species),
                  ),
                  FilterWidget(
                    onPressed: () => provider.toggleFilter(Filter.starships),
                    title: 'starships'.tr(),
                    active: provider.activeFilters.contains(Filter.starships),
                  ),
                  FilterWidget(
                    onPressed: () => provider.toggleFilter(Filter.vehicles),
                    title: 'vehicles'.tr(),
                    active: provider.activeFilters.contains(Filter.vehicles),
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: _mainPageWidget(provider),
            ),
          );
        },
      ),
    );
  }

  Widget _mainPageWidget(MainPageProvider provider) {
    switch (provider.state) {
      case MainPageState.loading:
        return const Loading();
      case MainPageState.ready:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextFormField(
                onChanged: (text) {
                  provider.search(text);
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.resources.length,
                  itemBuilder: (context, index) {
                    final resource = provider.resources[index];
                    switch (resource.runtimeType) {
                      case Film:
                        return Cell(
                          onPressed: () {
                            context.pushNamed(FilmDetails.pageName, extra: resource);
                          },
                          title: (resource as Film).title,
                        );
                      case Person:
                        return Cell(
                          onPressed: () {
                            context.pushNamed(PersonDetails.pageName, extra: resource);
                          },
                          title: (resource as Person).name,
                        );
                      case Planet:
                        return Cell(
                          onPressed: () {
                            context.pushNamed(PlanetDetails.pageName, extra: resource);
                          },
                          title: (resource as Planet).name,
                        );
                      case Specie:
                        return Cell(
                          onPressed: () {
                            context.pushNamed(SpecieDetails.pageName, extra: resource);
                          },
                          title: (resource as Specie).name,
                        );
                      case Starship:
                        return Cell(
                          onPressed: () {
                            context.pushNamed(StarshipDetails.pageName, extra: resource);
                          },
                          title: (resource as Starship).name,
                        );
                      case Vehicle:
                        return Cell(
                          onPressed: () {
                            context.pushNamed(VehicleDetails.pageName, extra: resource);
                          },
                          title: (resource as Vehicle).name,
                        );
                      default:
                        return const Cell(
                          title: 'unknown',
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      case MainPageState.error:
        return CustomErrorWidget(
          onTryAgain: () {
            provider.tryAgain();
          },
        );
    }
  }
}
