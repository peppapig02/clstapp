import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String message;
  final Color color;

  const MessageBox({
    super.key,
    required this.message,
    this.color = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(color: color, fontSize: 14),
      ),
    );
  }
}