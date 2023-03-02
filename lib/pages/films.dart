import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/pages/film_details.dart';
import 'package:swnumar1cs/providers/films_provider.dart';
import 'package:swnumar1cs/widgets/cell.dart';

class Films extends StatelessWidget {
  static const pageName = 'films';

  const Films({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('films'.tr()),
      ),
      body: ChangeNotifierProvider<FilmsProvider>(
        create: (context) => FilmsProvider(),
        child: Consumer<FilmsProvider>(
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
                      itemCount: provider.films.length,
                      itemBuilder: (context, index) {
                        return Cell(
                          onPressed: () {
                            context.pushNamed(FilmDetails.pageName, extra: provider.films[index]);
                          },
                          title: provider.films[index].title,
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
