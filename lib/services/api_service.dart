import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:user_api_app/core/constants/api_constants.dart';
import 'package:user_api_app/models/user_model.dart';

class ApiService {
  /// Fetches user data from API
  /// Returns ApiResponse with success flag
  /// No try-catch - simple success/failure return
  Future<ApiResponse> fetchUser(String userId) async {
    final response = await http.get(
      Uri.parse(ApiConstants.getUserUrl(userId)),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ApiResponse.fromJson(json);
    }

    return ApiResponse(
      success: false,
      error: ApiConstants.genericError,
    );
  }
}