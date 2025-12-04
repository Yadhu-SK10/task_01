import 'package:flutter/material.dart';
import 'package:user_api_app/models/user_model.dart';
import 'package:user_api_app/services/api_service.dart';
import 'package:user_api_app/core/constants/api_constants.dart';

enum ViewState { initial, loading, success, error }

class UserProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  ViewState _state = ViewState.initial;
  UserModel? _userData;
  String _errorMessage = '';

  ViewState get state => _state;
  UserModel? get userData => _userData;
  String get errorMessage => _errorMessage;

  Future<void> fetchUser(String userId) async {
    if (userId.isEmpty) {
      _state = ViewState.error;
      _errorMessage = ApiConstants.emptyUserIdError;
      notifyListeners();
      return;
    }

    _state = ViewState.loading;
    notifyListeners();

    try {
      _userData = await _apiService.fetchUser(userId);
      _state = ViewState.success;
      _errorMessage = '';
      notifyListeners();
    } on ApiException catch (e) {
      _state = ViewState.error;
      _errorMessage = e.message;
      _userData = null;
      notifyListeners();
    } catch (e) {
      _state = ViewState.error;
      _errorMessage = ApiConstants.genericError;
      _userData = null;
      notifyListeners();
    }
  }

  void reset() {
    _state = ViewState.initial;
    _userData = null;
    _errorMessage = '';
    notifyListeners();
  }
}