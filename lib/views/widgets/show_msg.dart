import 'package:flutter/material.dart';

void showErrorSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red, // Set the background color to red for errors
    ),
  );
}
