/// Jeux esport gérés par l'app. Sert à filtrer, à afficher un libellé et à
/// retrouver l'asset local du jeu.
enum GameType {
  lol,
  csgo,
  dota2,
  valorant;

  /// Convertit le slug PandaScore en GameType (null si le jeu n'est pas géré).
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

  /// Libellé court affiché dans l'UI (chips, cartes).
  String get label => switch (this) {
        GameType.lol => 'LoL',
        GameType.csgo => 'CS:2',
        GameType.dota2 => 'Dota 2',
        GameType.valorant => 'Valorant',
      };

  /// Préfixe d'URL PandaScore. CS2 utilise le préfixe legacy "csgo", pas "cs2".
  String get apiPrefix => switch (this) {
        GameType.lol => 'lol',
        GameType.csgo => 'csgo',
        GameType.dota2 => 'dota2',
        GameType.valorant => 'valorant',
      };

  /// Chemin de l'image locale du jeu (les logos ne sont pas fournis par l'API).
  String get assetPath => 'assets/games/$apiPrefix.png';
}
