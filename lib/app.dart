import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/match_repository.dart';
import 'features/matches/view/matches_screen.dart';
import 'features/matches/view_model/matches_view_model.dart';

/// Racine de l'app : fournit le repository (Provider) et le ViewModel de la
/// liste, applique le thème sombre et affiche l'écran liste.
class EsportArenaApp extends StatelessWidget {
  final MatchRepository repository;
  const EsportArenaApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: repository,
      child: MaterialApp(
        title: AppStrings.appTitle,
        theme: AppTheme.dark(),
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider(
          create: (_) => MatchesViewModel(repository)..load(),
          child: const MatchesScreen(),
        ),
      ),
    );
  }
}
