import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphview/GraphView.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:client/provider/automata.dart';
import 'package:client/provider/canvas/graph.dart';

import 'components/automata_table.dart';
import 'components/cart_title.dart';
import 'components/core/graph_dot.dart';
import 'components/core/styled_card.dart';

class GraphCanvas extends HookConsumerWidget {
  const GraphCanvas({super.key});

  static const routeName = '/graph';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graph = ref.watch(GraphNotifier.provider);
    final colors = ref.watch(GraphNotifier.provider.notifier).colorMap;

    final isTableVisible = useState(false);
    final automata = ref.watch(automataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualização de Autômato'),
        actions: [
          IconButton(
            onPressed: () => isTableVisible.value = !isTableVisible.value,
            icon: const Icon(Icons.table_chart),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
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
                if (isTableVisible.value)
                  Expanded(
                    child: StyledCard(
                      child: Column(
                        children: [
                          const CardTitle(text: 'Tabela:'),
                          AutomataTable(automata: automata),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            child: StyledCard(
              child: Column(
                children: [
                  const CardTitle(text: 'Legenda:'),
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
