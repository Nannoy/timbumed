import 'package:flutter/material.dart';
import 'package:timbumed/model/product.dart';

class FavoriteModel with ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  void add(Product product) {
    _favorites.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _favorites.remove(product);
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favorites.contains(product);
  }
}