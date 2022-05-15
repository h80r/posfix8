import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import 'package:client/provider/automata.dart';
import 'package:client/provider/canvas/graph.dart';

import 'components/automata_table.dart';
import 'components/cart_title.dart';
import 'components/core/graph_dot.dart';
import 'components/core/styled_card.dart';

class GraphCanvas extends ConsumerWidget {
  const GraphCanvas({super.key});

  static const routeName = '/graph';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graph = ref.watch(GraphNotifier.provider);
    final colors = ref.watch(GraphNotifier.provider.notifier).colorMap;

    final automata = ref.watch(automataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Visualização de Autômato')),
      body: Column(
        children: [
          Expanded(
            child: StyledCard(
              child: InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(8),
                constrained: false,
                minScale: 0.001,
                maxScale: 100,
                child: GraphView(
                  graph: graph,
                  algorithm: SugiyamaAlgorithm(SugiyamaConfiguration()),
                  builder: (Node node) => const GraphDot(),
                ),
              ),
            ),
          ),
          Expanded(
            child: StyledCard(
              child: Column(
                children: [
                  const CardTitle(text: 'Tabela:'),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: AutomataTable(automata: automata, colors: colors),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
