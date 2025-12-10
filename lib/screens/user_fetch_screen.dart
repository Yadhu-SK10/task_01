import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_api_app/providers/user_provider.dart';
import 'package:user_api_app/widgets/content_display_widget.dart';

class _AppColors {
  static const greenBorder = Color(0xFF4CAF50);
  static const primaryBlue = Color(0xFF2196F3);
  static const white = Colors.white;
  static const background = Color(0xFFFEF7FF);
  static const disabledBlue = Color(0xFF90CAF9);
  static const hintGrey = Color(0xFFBDBDBD);
}

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

  void _handleFetch() {
    FocusScope.of(context).unfocus();
    Provider.of<UserProvider>(context, listen: false)
        .fetchUser(_userIdController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _AppColors.background,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // 1. Text Field
              Container(
                // FIX: Width adjusted to 750
                width: 750,
                decoration: BoxDecoration(
                  color: _AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _AppColors.greenBorder, width: 2),
                ),
                child: TextField(
                  controller: _userIdController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    hintText: 'User ID',
                    hintStyle: TextStyle(
                      color: _AppColors.hintGrey,
                      fontSize: 16,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16),
                  onSubmitted: (_) => _handleFetch(),
                ),
              ),

              // 2. Button
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Consumer<UserProvider>(
                  builder: (context, provider, _) {
                    final isLoading = provider.state == ViewState.loading;

                    return ElevatedButton(
                      onPressed: isLoading ? null : _handleFetch,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _AppColors.primaryBlue,
                        foregroundColor: _AppColors.white,
                        disabledBackgroundColor: _AppColors.primaryBlue.withOpacity(0.7),
                        disabledForegroundColor: _AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Fetch User',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 3. Result Area
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