import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/pages/film_details.dart';
import 'package:swnumar1cs/pages/films.dart';
import 'package:swnumar1cs/pages/main_page.dart';

class RouterService {
  late final GoRouter _goRouter;

  GoRouter get router => _goRouter;

  RouterService() {
    _buildRouter();
  }

  void _buildRouter() {
    _goRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: MainPage.pageName,
          pageBuilder: (context, state) {
            return _buildMaterialPage(
              key: state.pageKey,
              child: const MainPage(),
            );
          },
        ),
        GoRoute(
          path: '/${Films.pageName}',
          name: Films.pageName,
          pageBuilder: (context, state) {
            return _buildMaterialPage(
              key: state.pageKey,
              child: const Films(),
            );
          },
        ),
        GoRoute(
          path: '/${FilmDetails.pageName}',
          name: FilmDetails.pageName,
          pageBuilder: (context, state) {
            final film = state.extra as Film;
            return _buildMaterialPage(
              key: state.pageKey,
              child: FilmDetails(film: film),
            );
          },
        ),
      ],
    );
  }

  Page<void> _buildMaterialPage({required LocalKey key, required Widget child}) {
    return MaterialPage<void>(
      key: key,
      child: child,
    );
  }
}
