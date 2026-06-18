/// Statut d'un match dans son cycle de vie.
enum MatchStatus {
  notStarted,
  running,
  finished;

  /// Convertit le statut texte de l'API en MatchStatus (défaut : notStarted).
  static MatchStatus fromApi(String status) {
    switch (status) {
      case 'running':
        return MatchStatus.running;
      case 'finished':
        return MatchStatus.finished;
      default:
        return MatchStatus.notStarted;
    }
  }
}
