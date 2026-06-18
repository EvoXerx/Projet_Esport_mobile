import 'match_summary.dart';
import 'player.dart';

class MatchDetail {
  final MatchSummary summary; // on réutilise tout le résumé (équipes, jeu, tournoi…)
  final int scoreA;
  final int scoreB;
  final String bestOf;        // "BO5"
  final List<Player> rosterA; // vides pour le #7, remplis au #8
  final List<Player> rosterB;
  final int? winProbA;        // [FALLBACK] null tant qu'aucune source -> barre masquée (#8)
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
