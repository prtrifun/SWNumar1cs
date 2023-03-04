import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/pages/starship_details.dart';
import 'package:swnumar1cs/providers/starships_provider.dart';
import 'package:swnumar1cs/services/starships_service.dart';
import 'package:swnumar1cs/widgets/cell.dart';
import 'package:swnumar1cs/widgets/custom_error_widget.dart';
import 'package:swnumar1cs/widgets/loading.dart';

class Starships extends StatelessWidget {
  static const pageName = 'starships';

  const Starships({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('starships'.tr()),
      ),
      body: ChangeNotifierProvider<StarshipsProvider>(
        create: (context) => StarshipsProvider(),
        child: Consumer<StarshipsProvider>(
          builder: (context, provider, _) {
            switch (provider.event) {
              case StarshipsServiceEvent.loading:
                return const Loading();
              case StarshipsServiceEvent.ready:
                return _starshipsWidget(provider);
              case StarshipsServiceEvent.error:
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

  Widget _starshipsWidget(StarshipsProvider provider) {
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
  }
}
