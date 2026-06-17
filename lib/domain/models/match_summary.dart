import '../../core/enums/game_type.dart';
import 'match_status.dart';
import 'team.dart';

class MatchSummary {
  final int id;
  final GameType? game; // null si jeu non géré par l'app -> le repository ignore le match
  final String tournamentName;
  final Team teamA;
  final Team teamB;
  final MatchStatus status;
  final String? currentMapLabel; // ex "Map 2", dérivé de games[]
  final DateTime? beginAt;

  const MatchSummary({
    required this.id,
    required this.game,
    required this.tournamentName,
    required this.teamA,
    required this.teamB,
    required this.status,
    this.currentMapLabel,
    this.beginAt,
  });
}
