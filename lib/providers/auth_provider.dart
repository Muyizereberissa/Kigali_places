import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  AuthProvider() {
    _user = FirebaseAuth.instance.currentUser;

    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signUp(String email, String password) async {
    try {
      _user = await _authService.signUp(email, password);
      notifyListeners();
      return true; // success
    } catch (e) {
      print("SignUp failed: $e");
      return false; // failure
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      _user = await _authService.login(email, password);
      notifyListeners();
      return true; // login successful
    } catch (e) {
      print("Login failed: $e");
      return false; // login failed
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}