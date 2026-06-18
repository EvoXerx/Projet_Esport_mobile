import '../../domain/models/player.dart';

/// Représentation JSON d'un joueur PandaScore (issu de `team.players[]`).
class PlayerDto {
  final int id;
  final String name;
  final String? role;
  final String? nationality;
  final String? imageUrl;

  const PlayerDto({
    required this.id,
    required this.name,
    this.role,
    this.nationality,
    this.imageUrl,
  });

  /// Construit un PlayerDto depuis le JSON de l'API.
  factory PlayerDto.fromJson(Map<String, dynamic> json) {
    return PlayerDto(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Unknown',
      role: json['role'] as String?,
      nationality: json['nationality'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }

  /// Convertit en [Player] domaine. Les K/D/A ne sont pas fournis par ce endpoint -> restent null.
  Player toDomain() {
    return Player(
      id: id,
      nickname: name,
      role: role,
      nationality: nationality,
      imageUrl: imageUrl,
    );
  }
}
