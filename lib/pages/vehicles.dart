import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/pages/vehicle_details.dart';
import 'package:swnumar1cs/providers/vehicles_provider.dart';
import 'package:swnumar1cs/services/vehicles_service.dart';
import 'package:swnumar1cs/widgets/cell.dart';
import 'package:swnumar1cs/widgets/custom_error_widget.dart';
import 'package:swnumar1cs/widgets/loading.dart';

class Vehicles extends StatelessWidget {
  static const pageName = 'vehicles';

  const Vehicles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('vehicles'.tr()),
      ),
      body: ChangeNotifierProvider<VehiclesProvider>(
        create: (context) => VehiclesProvider(),
        child: Consumer<VehiclesProvider>(
          builder: (context, provider, _) {
            switch (provider.event) {
              case VehiclesServiceEvent.loading:
                return const Loading();
              case VehiclesServiceEvent.ready:
                return _vehiclesWidget(provider);
              case VehiclesServiceEvent.error:
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

  Widget _vehiclesWidget(VehiclesProvider provider) {
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
              itemCount: provider.vehicle.length,
              itemBuilder: (context, index) {
                return Cell(
                  onPressed: () {
                    context.pushNamed(VehicleDetails.pageName, extra: provider.vehicle[index]);
                  },
                  title: provider.vehicle[index].name,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
