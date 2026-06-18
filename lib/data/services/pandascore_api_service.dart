import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';

/// Erreur réseau, HTTP ou de décodage remontée par le service.
class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}

/// Accès bas niveau à l'API PandaScore : renvoie le JSON brut décodé et lève une
/// [ApiException] en cas d'échec. Ne contient aucune logique métier.
class PandascoreApiService {
  final http.Client _client;

  PandascoreApiService(this._client);

  /// Matchs en cours, éventuellement filtrés par préfixe de jeu (ex. "csgo").
  Future<List<dynamic>> getRunningMatches({String? gamePrefix}) {
    final path = gamePrefix != null ? '/$gamePrefix/matches/running' : '/matches/running';
    return _getList(path);
  }

  /// Matchs à venir, éventuellement filtrés par préfixe de jeu.
  Future<List<dynamic>> getUpcomingMatches({String? gamePrefix}) {
    final path = gamePrefix != null ? '/$gamePrefix/matches/upcoming' : '/matches/upcoming';
    return _getList(path);
  }

  /// Détail d'un match par son id.
  Future<Map<String, dynamic>> getMatch(int id) => _getMap('/matches/$id');

  /// Fiche d'une équipe (contient `players[]`) par son id.
  Future<Map<String, dynamic>> getTeam(int id) => _getMap('/teams/$id');

  /// GET dont la réponse est une liste JSON.
  Future<List<dynamic>> _getList(String path) async {
    final body = await _get(path);
    return jsonDecode(body) as List<dynamic>;
  }

  /// GET dont la réponse est un objet JSON.
  Future<Map<String, dynamic>> _getMap(String path) async {
    final body = await _get(path);
    return jsonDecode(body) as Map<String, dynamic>;
  }

  /// Exécute le GET authentifié (Bearer token) et renvoie le corps brut, ou lève une [ApiException].
  Future<String> _get(String path) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$path');

    http.Response response;
    try {
      response = await _client.get(
        uri,
        headers: {'Authorization': 'Bearer ${ApiConstants.token}'},
      );
    } on http.ClientException catch (e) {
      throw ApiException('Erreur réseau: ${e.message}');
    }

    if (response.statusCode != 200) {
      throw ApiException('HTTP ${response.statusCode} sur $path');
    }

    return response.body;
  }
}
