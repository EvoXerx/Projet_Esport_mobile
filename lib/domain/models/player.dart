/// Joueur (modèle domaine). Les K/D/A et le rating ne sont pas fournis par
/// l'API standard -> restent null, et l'UI affiche "-/-/-".
class Player {
  final int id;
  final String nickname;
  final String? role;
  final String? nationality;
  final String? imageUrl;
  final int? kills;
  final int? deaths;
  final int? assists;
  final double? rating;

  const Player({
    required this.id,
    required this.nickname,
    this.role,
    this.nationality,
    this.imageUrl,
    this.kills,
    this.deaths,
    this.assists,
    this.rating,
  });
}
