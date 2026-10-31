import 'package:flutter/material.dart';

/// Atom: labeled text input.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.maxLines = 1,
    this.validator,
    this.autofocus = false,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String label;
  final int maxLines;
  final String? Function(String?)? validator;
  final bool autofocus;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      maxLines: maxLines,
      validator: validator,
      textInputAction: textInputAction,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: label),
    );
  }
}
