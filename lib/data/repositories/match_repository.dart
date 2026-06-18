import '../../core/enums/game_type.dart';
import '../../core/utils/result.dart';
import '../../domain/models/match_detail.dart';
import '../../domain/models/match_summary.dart';
import '../../domain/models/player.dart';
import '../models/match_dto.dart';
import '../models/player_dto.dart';
import '../services/pandascore_api_service.dart';

/// Transforme les données brutes du service en modèles domaine et encapsule les
/// erreurs dans un [Result]. Unique point d'entrée des données pour l'UI.
class MatchRepository {
  final PandascoreApiService _api;

  MatchRepository(this._api);

  /// Matchs en direct, filtrés par jeu si [filter] est fourni.
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

  /// Matchs à venir, filtrés par jeu si [filter] est fourni.
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

  /// Convertit le JSON brut en MatchSummary, en écartant les matchs sans 2 équipes
  /// et les jeux non gérés par l'app.
  List<MatchSummary> _mapToDomain(List<dynamic> raw) {
    return raw
        .map((json) => MatchDto.fromJson(json as Map<String, dynamic>).toDomain())
        .whereType<MatchSummary>()
        .where((m) => m.game != null)
        .toList();
  }

  /// Détail d'un match : score + bestOf, complété par les effectifs des 2 équipes.
  Future<Result<MatchDetail>> fetchMatchDetail(int id) async {
    try {
      final raw = await _api.getMatch(id);
      final base = MatchDto.fromJson(raw).toDetail();
      if (base == null) {
        return const Failure('Match indisponible');
      }

      final rosterA = await _fetchRoster(base.summary.teamA.id);
      final rosterB = await _fetchRoster(base.summary.teamB.id);

      return Success(MatchDetail(
        summary: base.summary,
        scoreA: base.scoreA,
        scoreB: base.scoreB,
        bestOf: base.bestOf,
        rosterA: rosterA,
        rosterB: rosterB,
      ));
    } on ApiException catch (e) {
      return Failure(e.message);
    } catch (e) {
      return Failure('Erreur inattendue: $e');
    }
  }

  /// Effectif d'une équipe ; renvoie une liste vide si l'appel échoue (pour ne pas casser l'écran).
  Future<List<Player>> _fetchRoster(int teamId) async {
    try {
      final raw = await _api.getTeam(teamId);
      return (raw['players'] as List<dynamic>? ?? [])
          .map((p) => PlayerDto.fromJson(p as Map<String, dynamic>).toDomain())
          .toList();
    } catch (_) {
      return [];
    }
  }
}
