import 'package:client/canvas/components/core/styled_card.dart';
import 'package:client/provider/canvas/automata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutomataCanvas extends ConsumerWidget {
  const AutomataCanvas({super.key});

  static const routeName = '/automata';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(ref.read(automataProvider));
    return Scaffold(
      appBar: AppBar(title: const Text('Automata Visualization')),
      body: Center(
        child: const StyledCard(child: Text('Automata')),
      ),
    );
  }
}
