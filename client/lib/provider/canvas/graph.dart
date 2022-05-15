import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../automata.dart';

class GraphNotifier extends StateNotifier<Graph> {
  GraphNotifier(
    this._automata,
    this._colorMap,
    this._kGoldenAngle,
  ) : super(Graph()) {
    loadAutomata();
  }

  final Map<String, Map<String, List<String>>> _automata;
  final Map<String, Color> _colorMap;
  final double _kGoldenAngle;

  static final provider = StateNotifierProvider<GraphNotifier, Graph>((ref) {
    return GraphNotifier(ref.watch(automataProvider), {}, 180 * (3 - sqrt(5)));
  });

  void loadAutomata() {
    final newGraph = Graph();

    final states = _automata.keys.map((e) => e.replaceAll('*', '')).toList();

    final nodes = states.map(Node.Id).toList();
    newGraph.addNodes(nodes);

    final edges = <Edge>[];
    for (final state in _automata.values) {
      for (final transition in state.entries) {
        for (final nextState in transition.value) {
          edges.add(Edge(
            nodes[_automata.values.toList().indexOf(state)],
            nodes[states.indexOf(nextState)],
            paint: Paint()
              ..color = _getColor(transition.key)
              ..strokeWidth = 2.0,
          ));
        }
      }
    }

    newGraph.addEdges(edges);

    state = newGraph;
  }

  Color _getColor(String id) {
    if (_colorMap.containsKey(id)) return _colorMap[id]!;

    final color = id == 'ε'
        ? Colors.white.withOpacity(0.5)
        : HSLColor.fromAHSL(
            1.0,
            (_colorMap.length * _kGoldenAngle) % 360.0,
            1.0,
            0.75,
          ).toColor();

    _colorMap[id] = color;
    return color;
  }

  Map<String, Color> get colorMap => {..._colorMap};
}
