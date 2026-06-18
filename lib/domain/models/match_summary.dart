import '../../core/enums/game_type.dart';
import 'match_status.dart';
import 'team.dart';

/// Résumé d'un match affiché dans la liste. `game` est null si le jeu n'est pas
/// géré (le repository écarte alors le match) ; `currentMapLabel` vient de games[].
class MatchSummary {
  final int id;
  final GameType? game;
  final String tournamentName;
  final Team teamA;
  final Team teamB;
  final MatchStatus status;
  final String? currentMapLabel;
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
