import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/pages/planet_details.dart';
import 'package:swnumar1cs/providers/planets_provider.dart';
import 'package:swnumar1cs/services/planets_service.dart';
import 'package:swnumar1cs/widgets/cell.dart';
import 'package:swnumar1cs/widgets/custom_error_widget.dart';
import 'package:swnumar1cs/widgets/loading.dart';

class Planets extends StatelessWidget {
  static const pageName = 'planets';

  const Planets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('planets'.tr()),
      ),
      body: ChangeNotifierProvider<PlanetsProvider>(
        create: (context) => PlanetsProvider(),
        child: Consumer<PlanetsProvider>(
          builder: (context, provider, _) {
            switch (provider.event) {
              case PlanetsServiceEvent.loading:
                return const Loading();
              case PlanetsServiceEvent.ready:
                return _planetsWidget(provider);
              case PlanetsServiceEvent.error:
                return CustomErrorWidget(
                  onTryAgain: () {
                    provider.tryAgain();
                  },
                );
            }
          },
        ),
      ),
    );
  }

  Widget _planetsWidget(PlanetsProvider provider) {
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
              itemCount: provider.planets.length,
              itemBuilder: (context, index) {
                return Cell(
                  onPressed: () {
                    context.pushNamed(PlanetDetails.pageName, extra: provider.planets[index]);
                  },
                  title: provider.planets[index].name,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
