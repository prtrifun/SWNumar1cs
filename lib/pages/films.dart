import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/constants.dart';
import 'package:swnumar1cs/providers/films_provider.dart';

class Films extends StatelessWidget {
  static const pageName = 'films';

  const Films({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kFilms),
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
                        return Text(provider.films[index].title ?? '');
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
