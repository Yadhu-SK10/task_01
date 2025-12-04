import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_api_app/providers/user_provider.dart';
import 'package:user_api_app/models/user_model.dart';

class ContentDisplayWidget extends StatelessWidget {
  const ContentDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return switch (userProvider.state) {
          ViewState.initial => _buildInitialState(),
          ViewState.loading => _buildLoadingState(),
          ViewState.success => _buildSuccessState(userProvider.userData!),
          ViewState.error => _buildErrorState(userProvider.errorMessage),
        };
      },
    );
  }

  Widget _buildInitialState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          'Enter a user ID (1, 2, or 3) and click Fetch User',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF4CAF50),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: CircularProgressIndicator(
          color: Color(0xFF2196F3),
        ),
      ),
    );
  }

  Widget _buildSuccessState(UserModel userData) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          width: 520,
          decoration: BoxDecoration(
            color: const Color(0xFF66BB6A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF2E7D32), width: 4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (userData.profileImage != null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      userData.profileImage!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(Icons.error, size: 50),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildInfoRow('Name', userData.name),
                      const SizedBox(height: 12),
                      _buildInfoRow('User ID', userData.userId),
                      const SizedBox(height: 12),
                      _buildInfoRow('Age', userData.age),
                      const SizedBox(height: 12),
                      _buildInfoRow('Profession', userData.profession),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          errorMessage,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 85,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const Text(
          ':',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFFEB3B),
            ),
          ),
        ),
      ],
    );
  }
}