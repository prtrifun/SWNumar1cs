import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/pages/vehicle_details.dart';
import 'package:swnumar1cs/providers/vehicles_provider.dart';
import 'package:swnumar1cs/widgets/cell.dart';

class Vehicles extends StatelessWidget {
  static const pageName = 'vehicles';

  const Vehicles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kVehicles),
      ),
      body: ChangeNotifierProvider<VehiclesProvider>(
        create: (context) => VehiclesProvider(),
        child: Consumer<VehiclesProvider>(
          builder: (context, provider, _) {
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
          },
        ),
      ),
    );
  }
}
