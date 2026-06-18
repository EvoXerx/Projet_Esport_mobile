import '../../domain/models/team.dart';

/// Représentation JSON d'une équipe PandaScore (couche data).
class TeamDto {
  final int id;
  final String name;
  final String? acronym;
  final String? imageUrl;
  final String? location;

  const TeamDto({
    required this.id,
    required this.name,
    this.acronym,
    this.imageUrl,
    this.location,
  });

  /// Construit un TeamDto depuis le JSON de l'API.
  factory TeamDto.fromJson(Map<String, dynamic> json) {
    return TeamDto(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'TBD',
      acronym: json['acronym'] as String?,
      imageUrl: json['image_url'] as String?,
      location: json['location'] as String?,
    );
  }

  /// Convertit ce DTO en modèle domaine [Team] (propre, indépendant de l'API).
  Team toDomain() {
    return Team(
      id: id,
      name: name,
      acronym: acronym,
      logoUrl: imageUrl,
      countryCode: location,
    );
  }
}
