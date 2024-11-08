import 'package:flutter/material.dart';
import 'package:weather_app/design_system/tokens/tokens_provider.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.hintText,
    required this.text,
    required this.textChange,
  });

  final String hintText;
  final String text;
  final Function(String?) textChange;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.text = widget.text;
    _controller.addListener(() => widget.textChange(_controller.text));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        filled: true,
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
        fillColor: context.colors.foreground.primary.white,
      ),
    );
  }
}
