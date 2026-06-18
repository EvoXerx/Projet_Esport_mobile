import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/repositories/match_repository.dart';
import '../../../domain/models/match_detail.dart';
import '../../../domain/models/match_status.dart';
import '../view_model/match_detail_view_model.dart';
import 'widgets/rosters_tab.dart';
import 'widgets/score_header.dart';

/// Écran détail : crée le ViewModel (en lisant le repository fourni globalement)
/// et affiche la vue interne.
class MatchDetailScreen extends StatelessWidget {
  final int matchId;
  const MatchDetailScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<MatchRepository>();
    return ChangeNotifierProvider(
      create: (_) => MatchDetailViewModel(repo, matchId)..load(),
      child: const _MatchDetailView(),
    );
  }
}

/// Vue interne : gère les états chargement/erreur, puis affiche les 2 onglets
/// Aperçu (score) et Effectifs.
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isLive
              ? 'LIVE • ${detail.summary.currentMapLabel ?? ''}'
              : detail.bestOf),
          bottom: const TabBar(
            tabs: [
              Tab(text: AppStrings.overview),
              Tab(text: AppStrings.rosters),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(children: [ScoreHeader(detail: detail)]),
            RostersTab(detail: detail),
          ],
        ),
      ),
    );
  }
}
