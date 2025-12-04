import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:user_api_app/core/constants/api_constants.dart';
import 'package:user_api_app/models/user_model.dart';

class ApiService {
  Future<UserModel> fetchUser(String userId) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.getUserUrl(userId)),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserModel.fromJson(data);
      } else {
        String errorMessage;
        try {
          final errorData = json.decode(response.body);
          errorMessage = errorData['error'] ?? errorData['message'] ?? response.body;
        } catch (e) {
          errorMessage = response.body;
        }
        throw ApiException(errorMessage);
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(ApiConstants.genericError);
    }
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}