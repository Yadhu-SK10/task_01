import 'package:flutter/material.dart';
import 'package:user_api_app/services/api_service.dart';
import 'package:user_api_app/models/user_model.dart';
import 'package:user_api_app/core/constants/api_constants.dart';
import 'package:user_api_app/widgets/initial_state_widget.dart';
import 'package:user_api_app/widgets/error_widget.dart';
import 'package:user_api_app/widgets/success_widget.dart';

class UserFetchScreen extends StatefulWidget {
  const UserFetchScreen({super.key});

  @override
  State<UserFetchScreen> createState() => _UserFetchScreenState();
}

class _UserFetchScreenState extends State<UserFetchScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final ApiService _apiService = ApiService();

  bool isLoading = false;
  bool showInitialState = true;
  bool showSuccess = false;
  bool showError = false;
  String errorMessage = '';
  UserModel? userData;

  Future<void> fetchUser() async {
    final userId = _userIdController.text.trim();

    if (userId.isEmpty) {
      setState(() {
        showInitialState = false;
        showSuccess = false;
        showError = true;
        errorMessage = ApiConstants.emptyUserIdError;
      });
      return;
    }

    setState(() {
      isLoading = true;
      showInitialState = false;
      showSuccess = false;
      showError = false;
    });

    try {
      final user = await _apiService.fetchUser(userId);

      setState(() {
        isLoading = false;
        userData = user;
        showSuccess = true;
        showError = false;
      });
    } on ApiException catch (e) {
      setState(() {
        isLoading = false;
        showSuccess = false;
        showError = true;
        errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        showSuccess = false;
        showError = true;
        errorMessage = ApiConstants.genericError;
      });
    }
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20), // Top spacing

            // Text Field with green border
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(
                hintText: '1',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2.5),
                ),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Fetch User Button - Blue
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : fetchUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: isLoading
                    ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
                    : const Text(
                  'Fetch User',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Content Area
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (showInitialState) {
      return const InitialStateWidget();
    }

    if (showError) {
      return ErrorDisplayWidget(errorMessage: errorMessage);
    }

    final user = userData;
    if (showSuccess && user != null) {
      return SuccessWidget(userData: user);
    }

    return const SizedBox.shrink();
  }
}