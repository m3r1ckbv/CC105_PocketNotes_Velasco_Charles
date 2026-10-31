import 'package:flutter/material.dart';

import '../../core/theme/semantic_colors.dart';
import 'icon_action_button.dart';

/// Atom (EXPERIMENT 2): star button. Filled star = favorite.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  final bool isFavorite;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconActionButton(
      icon: isFavorite ? Icons.star : Icons.star_border,
      color: isFavorite
          ? context.semantic.favorite
          : Theme.of(context).colorScheme.outline,
      tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
      onPressed: onPressed,
    );
  }
}
