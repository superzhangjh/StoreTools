import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool? obscureText;
  final TextInputType? keyboardType;

  const TextInputWidget({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText,
    this.keyboardType
  });

  @override
  State<StatefulWidget> createState() {
    return TextInputState();
  }
}

class TextInputState extends State<TextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return buildTextField();
  }

  Widget buildLabel(label) {
    return Text(label);
  }

  Widget buildTextField() {
    return Padding(
        padding: const EdgeInsets.all(10),
      child: TextField(
        obscureText: widget.obscureText ?? false,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder()
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}