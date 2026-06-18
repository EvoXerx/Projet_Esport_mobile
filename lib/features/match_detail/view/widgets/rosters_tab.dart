import 'package:flutter/material.dart';
import '../../../../domain/models/match_detail.dart';
import 'roster_row.dart';

/// Onglet Effectifs : les joueurs des 2 équipes, ou un message si indisponibles.
class RostersTab extends StatelessWidget {
  final MatchDetail detail;
  const RostersTab({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    if (detail.rosterA.isEmpty && detail.rosterB.isEmpty) {
      return const Center(child: Text('Effectifs indisponibles'));
    }
    return ListView(
      children: [
        _header(detail.summary.teamA.name),
        ...detail.rosterA.map((p) => RosterRow(player: p)),
        _header(detail.summary.teamB.name),
        ...detail.rosterB.map((p) => RosterRow(player: p)),
      ],
    );
  }

  /// En-tête avec le nom d'une équipe.
  Widget _header(String name) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Text(name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      );
}
