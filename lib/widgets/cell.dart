import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;

  const Cell({this.onPressed, this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        alignment: Alignment.centerLeft,
      ),
      child: Text(title ?? ''),
    );
  }
}
