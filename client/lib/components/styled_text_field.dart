import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
  const StyledTextField({
    Key? key,
    required this.labelText,
    this.onChanged,
    this.hintText,
    this.helperText,
  }) : super(key: key);

  final void Function(String?)? onChanged;
  final String? hintText;
  final String? helperText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        helperText: helperText,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
