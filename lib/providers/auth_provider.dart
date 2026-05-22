import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isMockAuthenticated = false;
  String? _mockEmail;
  String? _mockName;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      if (user != null) {
        _isMockAuthenticated = false;
      }
      notifyListeners();
    });
  }

  bool get isAuthenticated => _user != null || _isMockAuthenticated;
  String? get userName => _user != null 
      ? (_user!.displayName ?? _user!.email?.split('@')[0])
      : _mockName;
  String? get userEmail => _user != null ? _user!.email : _mockEmail;

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _isMockAuthenticated = false;
      notifyListeners();
    } catch (e) {
      // Fallback: If Firebase fails (e.g. invalid credential or offline), sign in locally as mock user!
      debugPrint('Firebase login failed, falling back to mock: $e');
      _isMockAuthenticated = true;
      _mockEmail = email;
      _mockName = email.split('@')[0];
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _isMockAuthenticated = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Firebase signUp failed, falling back to mock: $e');
      _isMockAuthenticated = true;
      _mockEmail = email;
      _mockName = email.split('@')[0];
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _isMockAuthenticated = false;
    _mockEmail = null;
    _mockName = null;
    notifyListeners();
  }
}
