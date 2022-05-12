import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    required this.onPressed,
    this.shape,
    this.child,
  });

  final VoidCallback? onPressed;
  final OutlinedBorder? shape;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        shape: shape ?? const StadiumBorder(),
      ),
      child: child,
    );
  }
}
