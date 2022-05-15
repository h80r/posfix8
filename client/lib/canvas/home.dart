import 'package:flutter/material.dart';

import 'package:client/provider/canvas/home.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/core/styled_button.dart';
import 'components/input_card.dart';
import 'components/output_card.dart';

class HomeCanvas extends ConsumerWidget {
  const HomeCanvas({super.key});

  static const routeName = '/';

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
          StyledButton(
            onPressed:
                state.currentExpression.isEmpty ? null : actions.onCalculate,
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
