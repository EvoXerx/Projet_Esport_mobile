import 'match_summary.dart';
import 'player.dart';

/// Détail d'un match : le résumé enrichi du score, du format (bestOf) et des
/// effectifs. `winProbA/B` restent null tant qu'aucune source ne les fournit.
class MatchDetail {
  final MatchSummary summary;
  final int scoreA;
  final int scoreB;
  final String bestOf;
  final List<Player> rosterA;
  final List<Player> rosterB;
  final int? winProbA;
  final int? winProbB;

  const MatchDetail({
    required this.summary,
    required this.scoreA,
    required this.scoreB,
    required this.bestOf,
    this.rosterA = const [],
    this.rosterB = const [],
    this.winProbA,
    this.winProbB,
  });
}
