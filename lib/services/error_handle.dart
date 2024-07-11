import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorHandle {
  static const invalidResponse = "Invalid response!";
  static const invalidData = "Invalid data!";

  void showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => context.go('/homeScreen'),
            ),
          ],
        );
      },
    );
  }
}
