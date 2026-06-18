import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/enums/game_type.dart';

/// Barre horizontale de filtres par jeu. `selected` null = "Tous". Widget
/// contrôlé : il ne stocke pas l'état, il prévient le parent via `onSelected`.
class GameFilterChips extends StatelessWidget {
  final GameType? selected;
  final ValueChanged<GameType?> onSelected;

  const GameFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _chip(AppStrings.allMatches, selected == null, () => onSelected(null)),
          for (final game in GameType.values)
            _chip(game.label, selected == game, () => onSelected(game)),
        ],
      ),
    );
  }

  /// Construit une puce sélectionnable (active = mise en avant).
  Widget _chip(String label, bool active, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: active,
        onSelected: (_) => onTap(),
      ),
    );
  }
}
