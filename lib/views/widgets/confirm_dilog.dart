import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          
          onPressed: onCancel,
          child: const Text('No'),
        ),
        ElevatedButton(
          
          onPressed: onConfirm,
          child: const Text('Yes'),
        ),
      ],
    );
  }
}

void showConfirmDialog(
    {required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmDialog(
        title: title,
        content: content,
        onConfirm: () {
          onConfirm();
          Navigator.of(context).pop(); // Close the dialog
        },
        onCancel: () {
          Navigator.of(context).pop(); // Close the dialog
        },
      );
    },
  );
}
