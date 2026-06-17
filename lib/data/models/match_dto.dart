import '../../core/enums/game_type.dart';
import '../../domain/models/match_status.dart';
import '../../domain/models/match_summary.dart';
import 'game_dto.dart';
import 'team_dto.dart';

class MatchDto {
  final int id;
  final String status;
  final DateTime? beginAt;
  final String videogameSlug;
  final String tournamentName;
  final List<TeamDto> opponents;
  final List<GameDto> games;

  const MatchDto({
    required this.id,
    required this.status,
    this.beginAt,
    required this.videogameSlug,
    required this.tournamentName,
    required this.opponents,
    required this.games,
  });

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
    );
  }

  static DateTime? _parseDate(String? raw) => raw == null ? null : DateTime.tryParse(raw);

  // null si moins de 2 adversaires connus (BYE) -> le repository ignore ce match.
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
}
