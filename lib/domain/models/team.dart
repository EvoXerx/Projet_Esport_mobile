/// Équipe (modèle domaine consommé par l'UI).
class Team {
  final int id;
  final String name;
  final String? acronym;
  final String? logoUrl;
  final String? countryCode;

  const Team({
    required this.id,
    required this.name,
    this.acronym,
    this.logoUrl,
    this.countryCode,
  });
}
