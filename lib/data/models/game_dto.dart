/// Représentation JSON d'une manche (game) d'un match. Sert à repérer la map en cours.
class GameDto {
  final int id;
  final int position;
  final String status;

  const GameDto({
    required this.id,
    required this.position,
    required this.status,
  });

  /// Construit un GameDto depuis le JSON de l'API.
  factory GameDto.fromJson(Map<String, dynamic> json) {
    return GameDto(
      id: json['id'] as int,
      position: json['position'] as int,
      status: json['status'] as String? ?? 'not_started',
    );
  }

  /// Vrai si cette manche est en cours (status "running").
  bool get isRunning => status == 'running';
}
