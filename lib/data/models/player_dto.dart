import '../../domain/models/player.dart';

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

  factory PlayerDto.fromJson(Map<String, dynamic> json) {
    return PlayerDto(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Unknown',
      role: json['role'] as String?,
      nationality: json['nationality'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }

  // kills/deaths/assists/rating : [FALLBACK] -> pas dans ce endpoint, restent null.
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
