import '../../core/enums/game_type.dart';
import '../../domain/models/match_detail.dart';
import '../../domain/models/match_status.dart';
import '../../domain/models/match_summary.dart';
import 'game_dto.dart';
import 'team_dto.dart';

/// Représentation JSON d'un match PandaScore. Sait se convertir en résumé
/// ([toDomain]) ou en détail ([toDetail]).
class MatchDto {
  final int id;
  final String status;
  final DateTime? beginAt;
  final String videogameSlug;
  final String tournamentName;
  final List<TeamDto> opponents;
  final List<GameDto> games;
  final int numberOfGames;
  final Map<int, int> scoresByTeamId;

  const MatchDto({
    required this.id,
    required this.status,
    this.beginAt,
    required this.videogameSlug,
    required this.tournamentName,
    required this.opponents,
    required this.games,
    required this.numberOfGames,
    required this.scoresByTeamId,
  });

  /// Construit un MatchDto depuis le JSON de l'API. Les résultats sans `team_id`
  /// (matchs 1v1 par joueur) sont ignorés dans le calcul des scores.
  factory MatchDto.fromJson(Map<String, dynamic> json) {
    final opponentsJson = json['opponents'] as List<dynamic>? ?? [];
    final gamesJson = json['games'] as List<dynamic>? ?? [];

    return MatchDto(
      id: json['id'] as int,
      status: json['status'] as String? ?? 'not_started',
      beginAt: _parseDate(json['begin_at'] as String? ?? json['scheduled_at'] as String?),
      videogameSlug: json['videogame']?['slug'] as String? ?? '',
      tournamentName: json['tournament']?['name'] as String? ??
          json['serie']?['full_name'] as String? ??
          json['league']?['name'] as String? ??
          'Tournoi inconnu',
      opponents: opponentsJson
          .map((o) => TeamDto.fromJson(o['opponent'] as Map<String, dynamic>))
          .toList(),
      games: gamesJson.map((g) => GameDto.fromJson(g as Map<String, dynamic>)).toList(),
      numberOfGames: json['number_of_games'] as int? ?? 1,
      scoresByTeamId: {
        for (final r in (json['results'] as List<dynamic>? ?? []))
          if (r['team_id'] != null)
            (r['team_id'] as int): (r['score'] as int? ?? 0),
      },
    );
  }

  /// Parse une date ISO, ou null si absente/invalide.
  static DateTime? _parseDate(String? raw) => raw == null ? null : DateTime.tryParse(raw);

  /// Convertit en résumé [MatchSummary] ; null si le match a moins de 2 équipes.
  MatchSummary? toDomain() {
    if (opponents.length < 2) return null;

    GameDto? runningGame;
    for (final g in games) {
      if (g.isRunning) {
        runningGame = g;
        break;
      }
    }

    return MatchSummary(
      id: id,
      game: GameType.fromSlug(videogameSlug),
      tournamentName: tournamentName,
      teamA: opponents[0].toDomain(),
      teamB: opponents[1].toDomain(),
      status: MatchStatus.fromApi(status),
      currentMapLabel: runningGame != null ? 'Map ${runningGame.position}' : null,
      beginAt: beginAt,
    );
  }

  /// Convertit en détail [MatchDetail] (score + bestOf) ; null si moins de 2 équipes.
  MatchDetail? toDetail() {
    final summary = toDomain();
    if (summary == null) return null;
    return MatchDetail(
      summary: summary,
      scoreA: scoresByTeamId[opponents[0].id] ?? 0,
      scoreB: scoresByTeamId[opponents[1].id] ?? 0,
      bestOf: 'BO$numberOfGames',
    );
  }
}
