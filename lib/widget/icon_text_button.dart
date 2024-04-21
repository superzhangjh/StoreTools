import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;

  const IconTextButton({super.key, required this.onPressed, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Row(
          children: [
            Icon(icon),
            Text(text)
          ],
        )
    );
  }
}