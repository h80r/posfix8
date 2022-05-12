import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import 'package:client/schema/automata_state.dart';

import '../automata.dart';

class GraphNotifier extends StateNotifier<Graph> {
  GraphNotifier(this._automata, this._colorMap, this._rnd) : super(Graph()) {
    loadAutomata();
  }

  final AutomataState _automata;
  final Map<String, Color> _colorMap;
  final Random _rnd;

  static final provider = StateNotifierProvider<GraphNotifier, Graph>((ref) {
    return GraphNotifier(ref.watch(automataProvider), {}, Random());
  });

  void loadAutomata() {
    final newGraph = Graph();

    final nodes = <Node>[];
    _addNode(_automata, nodes);
    newGraph.addNodes(nodes);

    _automata.reset();

    final edges = <Edge>[];
    _addEdge(_automata, nodes, edges);
    newGraph.addEdges(edges);

    state = newGraph;
  }

  void _addNode(AutomataState node, List<Node> nodes) {
    if (node.displayed) return;

    final newNode = Node.Id(node.id);
    node.displayed = true;
    nodes.add(newNode);

    node.children.forEach((key, value) {
      for (final child in value) {
        _addNode(child, nodes);
      }
    });
  }

  Color _getColor(String id) {
    if (_colorMap.containsKey(id)) return _colorMap[id]!;

    final color = Color.fromARGB(
      255,
      _rnd.nextInt(255) ~/ 2 + 128,
      _rnd.nextInt(255) ~/ 2 + 128,
      _rnd.nextInt(255) ~/ 2 + 128,
    );

    _colorMap[id] = color;
    return color;
  }

  void _addEdge(AutomataState node, List<Node> nodes, List<Edge> edges) {
    if (node.displayed) return;

    node.children.forEach((key, value) {
      for (final child in value) {
        final currentNode = nodes.firstWhere((n) => n.key?.value == node.id);
        final childNode = nodes.firstWhere((n) => n.key?.value == child.id);

        edges.add(
          Edge(
            currentNode,
            childNode,
            paint: Paint()
              ..color = _getColor(key)
              ..strokeWidth = 2.0,
          ),
        );
      }
    });

    node.displayed = true;

    node.children.forEach((key, value) {
      for (final child in value) {
        _addEdge(child, nodes, edges);
      }
    });
  }

  Map<String, Color> get colorMap => {..._colorMap};
}
