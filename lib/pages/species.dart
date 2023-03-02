import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/pages/specie_details.dart';
import 'package:swnumar1cs/providers/species_provider.dart';
import 'package:swnumar1cs/widgets/cell.dart';

class Species extends StatelessWidget {
  static const pageName = 'species';

  const Species({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('species'.tr()),
      ),
      body: ChangeNotifierProvider<SpeciesProvider>(
        create: (context) => SpeciesProvider(),
        child: Consumer<SpeciesProvider>(
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
                      itemCount: provider.species.length,
                      itemBuilder: (context, index) {
                        return Cell(
                          onPressed: () {
                            context.pushNamed(SpecieDetails.pageName, extra: provider.species[index]);
                          },
                          title: provider.species[index].name,
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
