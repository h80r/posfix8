import 'package:flutter/material.dart';

class StyledCard extends StatelessWidget {
  const StyledCard({
    Key? key,
    this.color,
    required this.child,
  }) : super(key: key);

  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: const EdgeInsets.all(20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(padding: const EdgeInsets.all(10.0), child: child),
    );
  }
}
