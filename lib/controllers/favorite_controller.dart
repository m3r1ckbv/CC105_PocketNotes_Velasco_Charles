import 'package:flutter/foundation.dart';

import '../data/models/task.dart';

/// EXPERIMENT 2: favorites kept ONLY in memory.
///
/// Deliberately NOT saved anywhere: not in SharedPreferences, not in sqflite,
/// and not a field of [Task] (so Task.toMap() never writes it to the DB).
/// The Set lives in RAM, so when the app process is closed and relaunched
/// it is empty again -> every star is back to "not favorite".
///
/// Stars survive while the app is running (e.g. theme toggle, add/edit/delete
/// of other tasks) because this controller outlives the widgets.
class FavoriteController extends ChangeNotifier {
  final Set<int> _favoriteIds = {}; // task ids that are starred (RAM only)

  bool isFavorite(Task task) =>
      task.id != null && _favoriteIds.contains(task.id);

  void toggle(Task task) {
    final id = task.id;
    if (id == null) return;
    if (!_favoriteIds.remove(id)) _favoriteIds.add(id);
    notifyListeners();
  }
}
