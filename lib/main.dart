import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'app.dart';
import 'data/repositories/match_repository.dart';
import 'data/services/pandascore_api_service.dart';

/// Point d'entrée : assemble la chaîne service -> repository et lance l'app.
void main() {
  final repository = MatchRepository(PandascoreApiService(http.Client()));
  runApp(EsportArenaApp(repository: repository));
}
