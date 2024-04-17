import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? value;
  final bool? obscureText;

  const TextInputWidget({super.key, required this.controller, required this.label, this.value, this.obscureText});

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