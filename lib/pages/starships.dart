import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/pages/starship_details.dart';
import 'package:swnumar1cs/providers/starships_provider.dart';
import 'package:swnumar1cs/widgets/cell.dart';

class Starships extends StatelessWidget {
  static const pageName = 'starships';

  const Starships({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kPlanets),
      ),
      body: ChangeNotifierProvider<StarshipsProvider>(
        create: (context) => StarshipsProvider(),
        child: Consumer<StarshipsProvider>(
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
                      itemCount: provider.starships.length,
                      itemBuilder: (context, index) {
                        return Cell(
                          onPressed: () {
                            context.pushNamed(StarshipDetails.pageName, extra: provider.starships[index]);
                          },
                          title: provider.starships[index].name,
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
