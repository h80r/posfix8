import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import 'package:client/provider/canvas/graph.dart';

import 'components/core/graph_dot.dart';
import 'components/core/styled_card.dart';

class GraphCanvas extends ConsumerWidget {
  const GraphCanvas({super.key});

  static const routeName = '/graph';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graph = ref.watch(GraphNotifier.provider);
    final colors = ref.watch(GraphNotifier.provider.notifier).colorMap;

    return Scaffold(
      appBar: AppBar(title: const Text('Automata Visualization')),
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            child: StyledCard(
              child: Column(
                children: [
                  const Text(
                    'Legenda:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            GraphDot(color: colors.values.elementAt(index)),
                            const SizedBox(width: 8),
                            Text(colors.keys.elementAt(index))
                          ],
                        ),
                      ),
                      itemCount: colors.length,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
