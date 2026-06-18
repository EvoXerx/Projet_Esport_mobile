import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_strings.dart';
import '../view_model/matches_view_model.dart';
import 'widgets/game_filter_chips.dart';
import 'widgets/match_card.dart';
import 'widgets/section_header.dart';
import '../../match_detail/view/match_detail_screen.dart';


class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

    void _openDetail(BuildContext context, int matchId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MatchDetailScreen(matchId: matchId)),
    );
  }


  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MatchesViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appTitle)),
      body: Column(
        children: [
          GameFilterChips(
            selected: vm.selectedFilter,
            onSelected: (game) => context.read<MatchesViewModel>().selectFilter(game),
          ),
          Expanded(child: _buildBody(context, vm)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, MatchesViewModel vm) {
    if (vm.isLoading && vm.liveMatches.isEmpty && vm.upcomingMatches.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (vm.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(vm.error!),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.read<MatchesViewModel>().load(),
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      );
    }
    if (vm.liveMatches.isEmpty && vm.upcomingMatches.isEmpty) {
      return const Center(child: Text(AppStrings.noMatch));
    }
    return ListView(
      children: [
        if (vm.liveMatches.isNotEmpty) const SectionHeader(AppStrings.liveSection),
        ...vm.liveMatches.map((m) => MatchCard(match: m, onTap: () => _openDetail(context, m.id))),
        if (vm.upcomingMatches.isNotEmpty) const SectionHeader(AppStrings.upcomingSection),
        ...vm.upcomingMatches.map((m) => MatchCard(match: m, onTap: () => _openDetail(context, m.id))),
      ],
    );
  }
  
}
