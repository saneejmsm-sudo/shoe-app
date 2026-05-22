import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Map<String, dynamic> toMap() {
    return {
      'shoe': shoe.toMap()..['id'] = shoe.id,
      'quantity': quantity,
      'selectedSize': selectedSize,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      shoe: Shoe.fromMap(map['shoe'] ?? {}, map['shoe']['id'] ?? ''),
      quantity: map['quantity'] ?? 1,
      selectedSize: map['selectedSize'] ?? '',
    );
  }
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  StreamSubscription<User?>? _authSubscription;
  String? _currentUserId;

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  CartProvider() {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _currentUserId = user.uid;
        _loadCartFromFirestore();
      } else {
        _currentUserId = null;
        _items.clear();
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadCartFromFirestore() async {
    if (_currentUserId == null) return;
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(_currentUserId).collection('cart').get();
      _items.clear();
      for (var d in doc.docs) {
        final data = d.data();
        final item = CartItem.fromMap(data);
        final key = '${item.shoe.id}-${item.selectedSize}';
        _items[key] = item;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading cart: $e');
    }
  }

  Future<void> _saveCartToFirestore() async {
    if (_currentUserId == null) return;
    try {
      final batch = FirebaseFirestore.instance.batch();
      final collectionRef = FirebaseFirestore.instance.collection('users').doc(_currentUserId).collection('cart');
      
      // Delete old cart entries
      final oldDocs = await collectionRef.get();
      for (var d in oldDocs.docs) {
        batch.delete(d.reference);
      }
      
      // Write new cart entries
      _items.forEach((key, item) {
        final docRef = collectionRef.doc(key);
        batch.set(docRef, item.toMap());
      });
      
      await batch.commit();
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

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
    _saveCartToFirestore();
  }

  void removeItem(String shoeId, String size) {
    _items.remove('$shoeId-$size');
    notifyListeners();
    _saveCartToFirestore();
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
      _saveCartToFirestore();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
    _saveCartToFirestore();
  }
}
