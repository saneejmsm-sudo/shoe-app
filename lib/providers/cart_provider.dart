import 'package:flutter/material.dart';
import '../models/models.dart';

class CartItem {
  final Shoe shoe;
  int quantity;
  String selectedSize;

  CartItem({
    required this.shoe,
    this.quantity = 1,
    required this.selectedSize,
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.shoe.price * cartItem.quantity;
    });
    return total;
  }

  double get subtotal => totalAmount;
  double get deliveryFee => totalAmount > 0 ? 10.0 : 0.0;
  double get total => subtotal + deliveryFee;

  void addItem(Shoe shoe, String size, {int quantity = 1}) {
    final key = '${shoe.id}-$size';
    if (_items.containsKey(key)) {
      _items[key]!.quantity += quantity;
    } else {
      _items[key] = CartItem(
        shoe: shoe,
        selectedSize: size,
        quantity: quantity,
      );
    }
    notifyListeners();
  }

  void removeItem(String shoeId, String size) {
    _items.remove('$shoeId-$size');
    notifyListeners();
  }

  void updateQuantity(String shoeId, String size, int quantity) {
    final key = '$shoeId-$size';
    if (_items.containsKey(key)) {
      if (quantity <= 0) {
        _items.remove(key);
      } else {
        _items[key]!.quantity = quantity;
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
