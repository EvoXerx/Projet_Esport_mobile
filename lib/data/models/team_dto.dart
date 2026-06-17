import '../../domain/models/team.dart';

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

  factory TeamDto.fromJson(Map<String, dynamic> json) {
    return TeamDto(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'TBD',
      acronym: json['acronym'] as String?,
      imageUrl: json['image_url'] as String?,
      location: json['location'] as String?,
    );
  }

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
