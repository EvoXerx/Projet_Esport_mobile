enum MatchStatus {
  notStarted,
  running,
  finished;

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
