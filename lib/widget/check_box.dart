import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  final bool isChecked;
  final void Function() onCheckChanged;

  const CheckBox({super.key, required this.onCheckChanged, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCheckChanged();
      },
      child: Icon(isChecked? Icons.check_box: Icons.check_box_outline_blank)
    );
  }
}
