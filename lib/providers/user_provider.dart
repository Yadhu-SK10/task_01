import 'package:flutter/material.dart';
import 'package:user_api_app/models/user_model.dart';
import 'package:user_api_app/services/api_service.dart';
import 'package:user_api_app/core/constants/api_constants.dart';

enum ViewState { initial, loading, success, error }

class UserProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  ViewState _state = ViewState.initial;
  User? _userData;
  String _errorMessage = '';

  ViewState get state => _state;
  User? get userData => _userData;
  String get errorMessage => _errorMessage;

  /// Fetches user data from API
  /// Uses simple success/failure check from ApiResponse
  /// Fetches user data from API
  /// Uses try-catch to ensure UI updates even if API fails (Caddayn Std Page 11)
  Future<void> fetchUser(String userId) async {
    // 1. Validation
    if (userId.isEmpty) {
      _state = ViewState.error;
      _errorMessage = ApiConstants.emptyUserIdError;
      notifyListeners();
      return;
    }

    // 2. Set Loading
    _state = ViewState.loading;
    notifyListeners();

    // 3. API Call with Safety (Try-Catch)
    try {
      final response = await _apiService.fetchUser(userId);

      if (response.success && response.data != null) {
        _state = ViewState.success;
        _userData = response.data!.user;
        _errorMessage = '';
      } else {
        _state = ViewState.error;
        // Use the error from API (e.g. "No user found") or generic fallback
        _errorMessage = response.error ?? ApiConstants.genericError;
        _userData = null;
      }
    } catch (e) {
      // 4. Catch Crashes (Network fail, Parsing fail)
      _state = ViewState.error;
      _errorMessage = ApiConstants.genericError; // Or e.toString() for debugging
      _userData = null;
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