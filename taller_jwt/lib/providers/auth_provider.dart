import 'package:flutter/material.dart';
import '../services/auth_service.dart';

enum AuthState { initial, loading, success, error }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  AuthState _state = AuthState.initial;
  AuthState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> checkAuthStatus() async {
    final token = await _authService.getToken();
    _isAuthenticated = token != null && token.isNotEmpty;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _state = AuthState.loading;
    notifyListeners();

    final result = await _authService.login(email, password);

    if (result['success'] == true) {
      _state = AuthState.success;
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } else {
      _state = AuthState.error;
      _errorMessage = result['message'] as String;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated = false;
    _state = AuthState.initial;
    notifyListeners();
  }
}
