import 'package:flutter/foundation.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';

final CartStore cartStore = CartStore();

class CartStore extends ChangeNotifier {
  final List<CartItem> _items = <CartItem>[];

  List<CartItem> get items => List<CartItem>.unmodifiable(_items);

  int get itemCount {
    return _items.fold<int>(0, (total, item) => total + item.quantity);
  }

  double get totalPrice {
    return _items.fold<double>(0, (total, item) => total + item.totalPrice);
  }

  bool get isEmpty => _items.isEmpty;

  void addProduct(Product product) {
    final int index = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index == -1) {
      _items.add(CartItem(product: product, quantity: 1));
    } else {
      final CartItem item = _items[index];
      _items[index] = item.copyWith(quantity: item.quantity + 1);
    }

    notifyListeners();
  }

  void decreaseProduct(Product product) {
    final int index = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index == -1) {
      return;
    }

    final CartItem item = _items[index];

    if (item.quantity <= 1) {
      _items.removeAt(index);
    } else {
      _items[index] = item.copyWith(quantity: item.quantity - 1);
    }

    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
