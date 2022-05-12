import 'package:flutter/material.dart';

class GraphDot extends StatelessWidget {
  const GraphDot({super.key, this.color = Colors.blue});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.0,
      height: 16.0,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
