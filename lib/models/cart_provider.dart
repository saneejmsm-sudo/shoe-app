import 'package:flutter/material.dart';
import 'shoe.dart';

class CartItem {
  final Shoe shoe;
  final int size;
  int quantity;

  CartItem({
    required this.shoe,
    required this.size,
    this.quantity = 1,
  });
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, i) => sum + i.quantity);

  double get subtotal =>
      _items.fold(0.0, (sum, i) => sum + i.shoe.price * i.quantity);

  double get shipping => _items.isEmpty ? 0.0 : 10.0;

  double get discount => subtotal >= 200 ? 20.0 : 0.0;

  double get total => subtotal + shipping - discount;

  void addToCart(Shoe shoe, int size) {
    final index = _items.indexWhere(
      (i) => i.shoe.id == shoe.id && i.size == size,
    );
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(shoe: shoe, size: size));
    }
    notifyListeners();
  }

  void increase(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrease(int index) {
    if (index >= 0 && index < _items.length) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void remove(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
