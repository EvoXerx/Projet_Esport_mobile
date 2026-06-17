class GameDto {
  final int id;
  final int position;
  final String status;

  const GameDto({
    required this.id,
    required this.position,
    required this.status,
  });

  factory GameDto.fromJson(Map<String, dynamic> json) {
    return GameDto(
      id: json['id'] as int,
      position: json['position'] as int,
      status: json['status'] as String? ?? 'not_started',
    );
  }

  bool get isRunning => status == 'running';
}
