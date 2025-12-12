import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_api_app/providers/user_provider.dart';
import 'package:user_api_app/models/user_model.dart';

class _WidgetColors {
  static const initialText = Color(0xFF4CAF50);
  static const spinnerColor = Color(0xFF7E57C2);
  static const cardBackground = Color(0xFF43A047);
  static const cardBorder = Color(0xFF2E7D32);
  static const labelWhite = Colors.white;
  static const valueYellow = Color(0xFFFFEB3B);
  static const errorRed = Colors.red;
  static const greyPlaceholder = Color(0xFFEEEEEE);
}

class ContentDisplayWidget extends StatelessWidget {
  const ContentDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: provider.state == ViewState.initial
              ? const Text(
            'Enter a user ID (1, 2, or 3) and click Fetch User',
            style: TextStyle(
              fontSize: 16,
              color: _WidgetColors.initialText,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
              : provider.state == ViewState.loading
              ? const SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: _WidgetColors.spinnerColor,
            ),
          )
              : provider.state == ViewState.success
              ? _SuccessCard(user: provider.userData!)
              : Text(
            provider.errorMessage,
            style: const TextStyle(
              fontSize: 16,
              color: _WidgetColors.errorRed,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}

class _SuccessCard extends StatelessWidget {
  final User user;

  const _SuccessCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750,
      decoration: BoxDecoration(
        color: _WidgetColors.cardBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: _WidgetColors.cardBorder, width: 3),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                user.profileImage,
                width: 320,
                height: 320,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 320,
                  height: 320,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error, size: 50),
                ),
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: 320,
                    height: 320,
                    color: _WidgetColors.greyPlaceholder,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailRow(label: 'Name', value: user.name),
                  const SizedBox(height: 1),
                  _DetailRow(label: 'User ID', value: user.userId.toString()),
                  const SizedBox(height: 1),
                  _DetailRow(label: 'Age', value: user.age.toString()),
                  const SizedBox(height: 1),
                  _DetailRow(label: 'Profession', value: user.profession),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _WidgetColors.labelWhite,
            ),
          ),
        ),
        const Text(
          ':',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _WidgetColors.labelWhite,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _WidgetColors.valueYellow,
            ),
          ),
        ),
      ],
    );
  }
}