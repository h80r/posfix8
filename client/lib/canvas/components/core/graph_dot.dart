import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class GraphDot extends StatelessWidget {
  const GraphDot(this.node, {super.key, this.color = Colors.blue});

  final Color color;
  final Node node;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Text(node.key?.value.toString() ?? ''),
    );
  }
}
