import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key? key, required this.title, required this.content, required this.onYes}) : super(key: key);

  final String title;
  final String content;
  final VoidCallback onYes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tidak'),
        ),
        TextButton(
            onPressed: onYes,
            child: const Text('Ya')
        ),
      ],
    );
  }
}
