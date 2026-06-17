import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';

class EsportArenaApp extends StatelessWidget {
  const EsportArenaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: AppTheme.dark(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(child: Text('Esport Arena')),
      ),
    );
  }
}