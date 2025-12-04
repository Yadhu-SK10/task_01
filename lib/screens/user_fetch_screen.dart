import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_api_app/providers/user_provider.dart';
import 'package:user_api_app/widgets/content_display_widget.dart';

class UserFetchScreen extends StatefulWidget {
  const UserFetchScreen({super.key});

  @override
  State<UserFetchScreen> createState() => _UserFetchScreenState();
}

class _UserFetchScreenState extends State<UserFetchScreen> {
  final TextEditingController _userIdController = TextEditingController();

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Text Field - Matching task sheet exactly
              Container(
                width: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xFF4CAF50), width: 2),
                ),
                child: TextField(
                  controller: _userIdController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),

              // Fetch User Button
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return ElevatedButton(
                    onPressed: userProvider.state == ViewState.loading
                        ? null
                        : () => userProvider.fetchUser(_userIdController.text.trim()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[400],
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 2,
                    ),
                    child: userProvider.state == ViewState.loading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
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
                  );
                },
              ),

              // Content Area - Moved upwards
              const Expanded(
                child: ContentDisplayWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}