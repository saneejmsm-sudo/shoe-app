import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';
import '../utils/app_data.dart';

class ShoeProvider with ChangeNotifier {
  List<Shoe> _shoes = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ShoeProvider() {
    fetchShoes();
  }

  Future<void> fetchShoes() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance.collection('shoes').get();
      
      if (snapshot.docs.isEmpty) {
        // Seed initial data if Firestore is empty
        await seedData();
        return;
      }

      _shoes = snapshot.docs.map((doc) => Shoe.fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      debugPrint('Error fetching shoes: $e');
      // Fallback to local data on error
      if (_shoes.isEmpty) {
        _shoes = AppData.shoes;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> seedData() async {
    try {
      final batch = FirebaseFirestore.instance.batch();
      for (var shoe in AppData.shoes) {
        final docRef = FirebaseFirestore.instance.collection('shoes').doc(shoe.id);
        batch.set(docRef, shoe.toMap());
      }
      await batch.commit();
      _shoes = AppData.shoes;
    } catch (e) {
      debugPrint('Error seeding data: $e');
    }
  }

  List<Shoe> get shoes {
    return _shoes.where((shoe) {
      final matchesCategory = _selectedCategory == 'All' || shoe.category == _selectedCategory;
      final matchesSearch = shoe.name.toLowerCase().contains(_searchQuery.toLowerCase()) || 
                           shoe.brand.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<Shoe> get featuredShoes => _shoes.take(3).toList();
  List<Shoe> get trendingShoes => _shoes.reversed.take(4).toList();

  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
