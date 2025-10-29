import 'package:flutter/material.dart';

class AppDialogs {
  static void showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
        backgroundColor: const Color(0xFF1E1E1E),
        content: Text(message),
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok', style: TextStyle(fontSize: 17)),
          ),
        ],
      ),
    );
  }
}
