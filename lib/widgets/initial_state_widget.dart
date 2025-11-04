import 'package:flutter/material.dart';

class InitialStateWidget extends StatelessWidget {
  const InitialStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Enter a user ID (1, 2, or 3) and click Fetch User',
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        textAlign: TextAlign.center,
      ),
    );
  }
}