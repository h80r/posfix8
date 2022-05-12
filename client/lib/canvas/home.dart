import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:client/provider/canvas/home.dart';

import 'components/input_card.dart';
import 'components/output_card.dart';

class HomeCanvas extends ConsumerWidget {
  const HomeCanvas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(HomeNotifier.provider);
    final actions = ref.watch(HomeNotifier.provider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Postfix')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputCard(
            onExpressionChanged: actions.onExpressionChanged,
            onExpectedChanged: actions.onExpectedChanged,
          ),
          ElevatedButton(
            onPressed:
                state.currentExpression.isEmpty ? null : actions.onCalculate,
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
            ),
            child: const Text('CALCULAR'),
          ),
          OutputCard(
            result: state.result ?? '',
            exception: state.exception ?? '',
            expectedResult: state.expectedResult,
            resultValidation: state.resultValidation,
          ),
        ],
      ),
    );
  }
}
