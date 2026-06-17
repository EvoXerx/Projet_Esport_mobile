class Player {
  final int id;
  final String nickname;
  final String? role;
  final String? nationality;
  final String? imageUrl;

  // [FALLBACK] null tant que les stats détaillées de game ne sont pas branchées.
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
