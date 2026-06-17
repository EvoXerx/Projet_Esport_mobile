import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/enums/game_type.dart';
import '../../../domain/models/match_status.dart';
import '../../../domain/models/match_summary.dart';
import '../../../domain/models/team.dart';
import 'widgets/game_filter_chips.dart';
import 'widgets/match_card.dart';
import 'widgets/section_header.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  GameType? _filter;

  // Match factice pour tester l'affichage (TEMPORAIRE — sera remplacé par le ViewModel)
  final _fake = const MatchSummary(
    id: 1,
    game: GameType.csgo,
    tournamentName: 'PGL Major',
    teamA: Team(id: 1, name: 'Vitality'),
    teamB: Team(id: 2, name: 'NAVI'),
    status: MatchStatus.running,
    currentMapLabel: 'Map 1',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appTitle)),
      body: ListView(
        children: [
          GameFilterChips(
            selected: _filter,
            onSelected: (game) => setState(() => _filter = game),
          ),
          const SectionHeader(AppStrings.liveSection),
          MatchCard(match: _fake, onTap: () {}),
        ],
      ),
    );
  }
}
