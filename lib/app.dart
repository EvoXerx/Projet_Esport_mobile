import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'features/matches/view/matches_screen.dart';


class EsportArenaApp extends StatelessWidget {
  const EsportArenaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: AppTheme.dark(),
      debugShowCheckedModeBanner: false,
            home: const MatchesScreen(), // remplace l'ancien Scaffold "Esport Arena"
    );
  }
}