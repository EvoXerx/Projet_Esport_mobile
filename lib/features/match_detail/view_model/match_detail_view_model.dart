import 'package:flutter/foundation.dart';
import '../../../core/utils/result.dart';
import '../../../data/repositories/match_repository.dart';
import '../../../domain/models/match_detail.dart';

class MatchDetailViewModel extends ChangeNotifier {
  final MatchRepository _repo;
  final int matchId;
  MatchDetailViewModel(this._repo, this.matchId);

  bool isLoading = false;
  String? error;
  MatchDetail? detail;

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _repo.fetchMatchDetail(matchId);
    switch (result) {
      case Success(:final value):
        detail = value;
      case Failure(:final message):
        error = message;
    }

    isLoading = false;
    notifyListeners();
  }
}
