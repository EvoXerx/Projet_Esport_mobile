import 'package:flutter/foundation.dart';
import '../../../core/enums/game_type.dart';
import '../../../core/utils/result.dart';
import '../../../data/repositories/match_repository.dart';
import '../../../domain/models/match_summary.dart';

/// État de l'écran liste : matchs live/à venir, filtre de jeu, chargement, erreur.
class MatchesViewModel extends ChangeNotifier {
  final MatchRepository _repo;
  MatchesViewModel(this._repo);

  bool isLoading = false;
  String? error;
  GameType? selectedFilter;
  List<MatchSummary> liveMatches = [];
  List<MatchSummary> upcomingMatches = [];

  /// Charge les matchs live et à venir (selon le filtre courant) et notifie l'UI.
  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final liveResult = await _repo.fetchLiveMatches(filter: selectedFilter);
    final upcomingResult = await _repo.fetchUpcomingMatches(filter: selectedFilter);

    switch (liveResult) {
      case Success(:final value):
        liveMatches = value;
      case Failure(:final message):
        error = message;
    }
    switch (upcomingResult) {
      case Success(:final value):
        upcomingMatches = value;
      case Failure(:final message):
        error = message;
    }

    isLoading = false;
    notifyListeners();
  }

  /// Change le filtre de jeu sélectionné et recharge les matchs.
  void selectFilter(GameType? game) {
    selectedFilter = game;
    load();
  }
}
