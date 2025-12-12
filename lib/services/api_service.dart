import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_api_app/core/constants/api_constants.dart';
import 'package:user_api_app/models/user_model.dart';

class ApiService {
  Future<ApiResponse> fetchUser(String userId) async {
    try {
      // Construct URL using your existing ApiConstants
      final uri = Uri.parse('${ApiConstants.baseUrl}/users/$userId');
      final response = await http.get(uri);

      // FIX: Always try to decode the body to get "No user found" message
      if (response.body.isNotEmpty) {
        final json = jsonDecode(response.body);
        return ApiResponse.fromJson(json);
      }

      return ApiResponse(
        success: false,
        error: 'Something went wrong',
      );

    } catch (e) {
      // Handles No Internet / SocketException
      return ApiResponse(
        success: false,
        error: 'Something went wrong',
      );
    }
  }
}