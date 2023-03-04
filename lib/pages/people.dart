import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/pages/person_details.dart';
import 'package:swnumar1cs/providers/people_provider.dart';
import 'package:swnumar1cs/services/people_service.dart';
import 'package:swnumar1cs/widgets/cell.dart';
import 'package:swnumar1cs/widgets/custom_error_widget.dart';
import 'package:swnumar1cs/widgets/loading.dart';

class People extends StatelessWidget {
  static const pageName = 'people';

  const People({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('people'.tr()),
      ),
      body: ChangeNotifierProvider<PeopleProvider>(
        create: (context) => PeopleProvider(),
        child: Consumer<PeopleProvider>(
          builder: (context, provider, _) {
            switch (provider.event) {
              case PeopleServiceEvent.loading:
                return const Loading();
              case PeopleServiceEvent.ready:
                return _peopleWidget(provider);
              case PeopleServiceEvent.error:
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

  Widget _peopleWidget(PeopleProvider provider) {
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
              itemCount: provider.people.length,
              itemBuilder: (context, index) {
                return Cell(
                  onPressed: () {
                    context.pushNamed(PersonDetails.pageName, extra: provider.people[index]);
                  },
                  title: provider.people[index].name,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
