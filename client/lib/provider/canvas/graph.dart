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

  final Map<String, dynamic> _automata;
  final Map<String, Color> _colorMap;
  final double _kGoldenAngle;

  static final provider = StateNotifierProvider<GraphNotifier, Graph>((ref) {
    return GraphNotifier(ref.watch(automataProvider), {}, 180 * (3 - sqrt(5)));
  });

  void loadAutomata() {
    final newGraph = Graph();

    final states = (_automata['states'] as List)
        .cast<String>()
        .map((e) => e.replaceAll('*', ''))
        .toList();
    final alphabet = (_automata['alphabet'] as List).cast<String>();
    final table = (_automata['table'] as List)
        .cast<List>()
        .map((e) => e.cast<List?>().map((e) => e?.cast<String>()).toList())
        .toList();

    final nodes = states.map(Node.Id).toList();
    newGraph.addNodes(nodes);

    final edges = <Edge>[];
    for (var i = 0; i < states.length; i++) {
      for (var j = 0; j < alphabet.length; j++) {
        final transition = table[i][j];
        if (transition == null) continue;

        final from = nodes[i];
        final symbol = alphabet[j];

        for (final to in transition) {
          final toNode = nodes.firstWhere((e) => e.key?.value == to);
          edges.add(Edge(
            from,
            toNode,
            paint: Paint()
              ..color = _getColor(symbol)
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
