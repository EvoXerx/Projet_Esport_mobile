import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../domain/models/match_status.dart';
import '../../../../domain/models/match_summary.dart';
import 'live_badge.dart';

class MatchCard extends StatelessWidget {
  final MatchSummary match;
  final VoidCallback onTap; // ce qui se passe au clic (décidé par le parent)

  const MatchCard({super.key, required this.match, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ligne du haut : logo jeu + tournoi + badge LIVE
              Row(
                children: [
                  if (match.game != null)
                    Image.asset(match.game!.assetPath, width: 20, height: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      match.tournamentName,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                  if (match.status == MatchStatus.running) const LiveBadge(),
                ],
              ),
              const SizedBox(height: 16),
              // Ligne des équipes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _TeamName(name: match.teamA.name),
                  const Text('VS', style: TextStyle(color: AppColors.textSecondary)),
                  _TeamName(name: match.teamB.name),
                ],
              ),
              const SizedBox(height: 12),
              // Ligne du bas : Stats + Parier (décoratifs)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.stats, style: TextStyle(color: AppColors.textSecondary)),
                  Text(AppStrings.betNow, style: TextStyle(color: AppColors.accent)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TeamName extends StatelessWidget {
  final String name;
  const _TeamName({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}
