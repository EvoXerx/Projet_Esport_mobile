import '../../core/enums/game_type.dart';
import '../../core/utils/result.dart';
import '../../domain/models/match_summary.dart';
import '../models/match_dto.dart';
import '../services/pandascore_api_service.dart';

class MatchRepository {
  final PandascoreApiService _api;

  MatchRepository(this._api);

  Future<Result<List<MatchSummary>>> fetchLiveMatches({GameType? filter}) async {
    try {
      final raw = await _api.getRunningMatches(gamePrefix: filter?.apiPrefix);
      return Success(_mapToDomain(raw));
    } on ApiException catch (e) {
      return Failure(e.message);
    } catch (e) {
      return Failure('Erreur inattendue: $e');
    }
  }

  Future<Result<List<MatchSummary>>> fetchUpcomingMatches({GameType? filter}) async {
    try {
      final raw = await _api.getUpcomingMatches(gamePrefix: filter?.apiPrefix);
      return Success(_mapToDomain(raw));
    } on ApiException catch (e) {
      return Failure(e.message);
    } catch (e) {
      return Failure('Erreur inattendue: $e');
    }
  }

  // JSON brut -> MatchSummary propres, en retirant les matchs inutilisables.
  List<MatchSummary> _mapToDomain(List<dynamic> raw) {
    return raw
        .map((json) => MatchDto.fromJson(json as Map<String, dynamic>).toDomain())
        .whereType<MatchSummary>() // retire les null (match avec < 2 équipes)
        .where((m) => m.game != null) // retire les jeux non gérés par l'app
        .toList();
  }
}
