import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/repositories/match_repository.dart';
import '../../../domain/models/match_detail.dart';
import '../../../domain/models/match_status.dart';
import '../view_model/match_detail_view_model.dart';
import 'widgets/score_header.dart';

class MatchDetailScreen extends StatelessWidget {
  final int matchId;
  const MatchDetailScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<MatchRepository>(); // fourni globalement (étape 4)
    return ChangeNotifierProvider(
      create: (_) => MatchDetailViewModel(repo, matchId)..load(),
      child: const _MatchDetailView(),
    );
  }
}

class _MatchDetailView extends StatelessWidget {
  const _MatchDetailView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MatchDetailViewModel>();

    if (vm.isLoading && vm.detail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (vm.error != null || vm.detail == null) {
      return Scaffold(appBar: AppBar(), body: Center(child: Text(vm.error ?? 'Erreur')));
    }

    final MatchDetail detail = vm.detail!;
    final isLive = detail.summary.status == MatchStatus.running;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isLive
              ? 'LIVE • ${detail.summary.currentMapLabel ?? ''}'
              : detail.bestOf),
          bottom: const TabBar(
            tabs: [
              Tab(text: AppStrings.overview),
              Tab(text: AppStrings.rosters),
              Tab(text: AppStrings.analytics),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(children: [ScoreHeader(detail: detail)]),     // Aperçu
            const Center(child: Text(AppStrings.rosters)),          // Effectifs (#8)
            const Center(child: Text(AppStrings.analyticsSoon)),    // Analyses (placeholder)
          ],
        ),
      ),
    );
  }
}
