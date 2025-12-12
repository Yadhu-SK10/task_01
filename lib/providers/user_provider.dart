import 'package:flutter/material.dart';
import 'package:user_api_app/models/user_model.dart';
import 'package:user_api_app/services/api_service.dart'; // Corrected Path

enum ViewState { initial, loading, success, error }

class UserProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  ViewState _state = ViewState.initial;
  User? _userData;
  String _errorMessage = '';

  ViewState get state => _state;
  User? get userData => _userData;
  String get errorMessage => _errorMessage;

  Future<void> fetchUser(String userId) async {
    final cleanId = userId.trim();

    if (cleanId.isEmpty) {
      _state = ViewState.error;
      _errorMessage = 'Please enter a user ID';
      notifyListeners();
      return;
    }

    _state = ViewState.loading;
    notifyListeners();

    try {
      final response = await _apiService.fetchUser(cleanId);

      if (response.success && response.data != null) {
        _state = ViewState.success;
        _userData = response.data!.user;
        _errorMessage = '';
      } else {
        _state = ViewState.error;
        _userData = null;
        // Uses the error from API (e.g. "No user found")
        _errorMessage = response.error ?? 'Something went wrong';
      }
    } catch (e) {
      _state = ViewState.error;
      _userData = null;
      _errorMessage = 'Something went wrong';
    }

    notifyListeners();
  }

  void clearProvider() {
    _state = ViewState.initial;
    _userData = null;
    _errorMessage = '';
    notifyListeners();
  }
}