import 'package:flutter/material.dart';

class SnackbarService {
  showSnackBar({
    required BuildContext context,
    required String message,
    required bool isError,
  }) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      backgroundColor: (isError) ? Colors.red[500] : Colors.green[500],
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
