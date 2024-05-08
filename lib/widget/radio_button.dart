import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final bool isChecked;
  final String title;
  final void Function() onCheckChanged;

  const RadioButton({super.key, required this.title, required this.onCheckChanged, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCheckChanged();
      },
      child: Row(
        children: [
          Icon(isChecked? Icons.radio_button_checked: Icons.radio_button_off),
          Text(title),
        ],
      ),
    );
  }
}
