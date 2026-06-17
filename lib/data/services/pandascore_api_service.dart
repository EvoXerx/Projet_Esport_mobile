import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}

class PandascoreApiService {
  final http.Client _client;

  PandascoreApiService(this._client);

  Future<List<dynamic>> getRunningMatches({String? gamePrefix}) {
    final path = gamePrefix != null ? '/$gamePrefix/matches/running' : '/matches/running';
    return _getList(path);
  }

  Future<List<dynamic>> getUpcomingMatches({String? gamePrefix}) {
    final path = gamePrefix != null ? '/$gamePrefix/matches/upcoming' : '/matches/upcoming';
    return _getList(path);
  }

  Future<Map<String, dynamic>> getMatch(int id) => _getMap('/matches/$id');

  Future<Map<String, dynamic>> getTeam(int id) => _getMap('/teams/$id');

  Future<List<dynamic>> _getList(String path) async {
    final body = await _get(path);
    return jsonDecode(body) as List<dynamic>;
  }

  Future<Map<String, dynamic>> _getMap(String path) async {
    final body = await _get(path);
    return jsonDecode(body) as Map<String, dynamic>;
  }

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
