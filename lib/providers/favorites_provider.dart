import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  final List<String> _favoriteIds = [];

  List<String> get favoriteIds => [..._favoriteIds];

  bool isFavorite(String shoeId) {
    return _favoriteIds.contains(shoeId);
  }

  void toggleFavorite(String shoeId) {
    if (_favoriteIds.contains(shoeId)) {
      _favoriteIds.remove(shoeId);
    } else {
      _favoriteIds.add(shoeId);
    }
    notifyListeners();
  }
}
