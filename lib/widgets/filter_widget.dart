import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  final String title;
  final bool active;
  final VoidCallback? onPressed;

  const FilterWidget({this.title = '', this.active = false, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            if (active)
              const Icon(
                Icons.check,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }
}
