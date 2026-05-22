import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';
import '../models/models.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<Order> get orders => [..._orders];

  OrderProvider() {
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .orderBy('date', descending: true)
          .get();

      _orders = snapshot.docs.map((doc) => Order.fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      debugPrint('Error fetching orders: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addOrder(List<OrderItem> items, double total) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Temp ID
      items: items,
      totalAmount: total,
      date: DateTime.now(),
    );

    _orders.insert(0, newOrder);
    notifyListeners();

    try {
      final docRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .add(newOrder.toMap());
      
      // Update the local order ID with Firestore's document ID
      final orderIndex = _orders.indexOf(newOrder);
      if (orderIndex >= 0) {
        _orders[orderIndex] = Order(
          id: docRef.id,
          items: newOrder.items,
          totalAmount: newOrder.totalAmount,
          date: newOrder.date,
          status: newOrder.status,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error adding order: $e');
      _orders.remove(newOrder); // Rollback on error
      notifyListeners();
      rethrow;
    }
  }
}
