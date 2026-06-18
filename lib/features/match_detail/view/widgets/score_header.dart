import 'package:flutter/material.dart';
import '../../../../domain/models/match_detail.dart';

/// En-tête de l'onglet Aperçu : les 2 équipes, le score et le format (bestOf).
class ScoreHeader extends StatelessWidget {
  final MatchDetail detail;
  const ScoreHeader({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: _team(detail.summary.teamA.name)),
          Column(
            children: [
              Text('${detail.scoreA} - ${detail.scoreB}',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Text(detail.bestOf),
            ],
          ),
          Expanded(child: _team(detail.summary.teamB.name)),
        ],
      ),
    );
  }

  /// Colonne icône + nom d'une équipe.
  Widget _team(String name) => Column(
        children: [
          const Icon(Icons.shield, size: 40),
          const SizedBox(height: 8),
          Text(name, textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      );
}
