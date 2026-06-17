enum GameType {
  lol,
  csgo,
  dota2,
  valorant;

  static GameType? fromSlug(String slug) {
    switch (slug) {
      case 'league-of-legends':
        return GameType.lol;
      case 'cs-go':
        return GameType.csgo;
      case 'dota-2':
        return GameType.dota2;
      case 'valorant':
        return GameType.valorant;
      default:
        return null;
    }
  }

  String get label => switch (this) {
        GameType.lol => 'LoL',
        GameType.csgo => 'CS:2',
        GameType.dota2 => 'Dota 2',
        GameType.valorant => 'Valorant',
      };

  // CS2 utilise le préfixe legacy "csgo" côté API PandaScore.
  String get apiPrefix => switch (this) {
        GameType.lol => 'lol',
        GameType.csgo => 'csgo',
        GameType.dota2 => 'dota2',
        GameType.valorant => 'valorant',
      };

  String get assetPath => 'assets/games/$apiPrefix.png';
}
