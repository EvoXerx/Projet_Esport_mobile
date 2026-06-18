import 'package:flutter/material.dart';
import '../../../../domain/models/player.dart';

/// Ligne d'un joueur dans l'effectif : pseudo, rôle et K/D/A (ou "-/-/-").
class RosterRow extends StatelessWidget {
  final Player player;
  const RosterRow({super.key, required this.player});

  /// K/D/A formaté, ou "-/-/-" si une des valeurs est absente.
  String get _kda {
    if (player.kills == null || player.deaths == null || player.assists == null) {
      return '-/-/-';
    }
    return '${player.kills}/${player.deaths}/${player.assists}';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(player.nickname),
      subtitle: player.role != null ? Text(player.role!) : null,
      trailing: Text(_kda),
    );
  }
}
