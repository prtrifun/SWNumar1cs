import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swnumar1cs/providers/films_provider.dart';

class Films extends StatelessWidget {
  static const pageName = 'films';

  const Films({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<FilmsProvider>(
        create: (context) => FilmsProvider(),
        child: Consumer<FilmsProvider>(
          builder: (context, provider, _) {
            return ListView.builder(
              itemCount: provider.films.length,
              itemBuilder: (context, index) {
                return Text(provider.films[index].title ?? '');
              },
            );
          },
        ),
      ),
    );
  }
}
