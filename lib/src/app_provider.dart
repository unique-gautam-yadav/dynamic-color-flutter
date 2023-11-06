import 'package:flutter/material.dart';

import 'backend/models.dart';

class AppProvider extends ChangeNotifier {
  final List<ShoeModel> _products = [];

  List<ShoeModel> get products => _products;

  addProduct(ShoeModel product) {
    _products.add(product);
    notifyListeners();
  }

  removeProduct(ShoeModel product) {
    _products.remove(product);
    notifyListeners();
  }
}
