import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final String label;
  final String? value;

  const TextInputWidget({super.key, required this.label, this.value});

  @override
  State<StatefulWidget> createState() {
    return TextInputState();
  }
}

class TextInputState extends State<TextInputWidget> {
  final TextEditingController _controller = TextEditingController();

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
        controller: _controller,
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder()
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}