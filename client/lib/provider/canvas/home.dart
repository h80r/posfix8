import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:client/schema/canvas/home.dart';

import '../automata.dart';
import '../services.dart';

class HomeNotifier extends StateNotifier<HomeSchema> {
  HomeNotifier(
    this._services,
    this._automataNotifier,
  ) : super(HomeSchema.initial());

  final ServicesProvider _services;
  final StateNotifier _automataNotifier;

  static final provider = StateNotifierProvider<HomeNotifier, HomeSchema>(
    (ref) => HomeNotifier(
      ref.watch(ServicesProvider.provider),
      ref.watch(automataProvider.notifier),
    ),
  );

  void onExpressionChanged(String? value) {
    state = state.copyWith(currentExpression: value ?? '');
  }

  void onExpectedChanged(String? value) {
    state = state.copyWith(expectedResult: value ?? '');
  }

  void onCalculate() async {
    final response = await _services.get(
      state.currentExpression,
      state.expectedResult,
    );

    final automaton = response?['automaton'] as Map<String, dynamic>?;

    if (automaton != null) {
      final states = (automaton['states'] as List).cast<String>();

      final alphabet = (automaton['alphabet'] as List).cast<String>();

      final table = (automaton['table'] as List)
          .cast<List>()
          .map((e) => e.cast<List?>().map((e) => e?.cast<String>()).toList())
          .toList();

      _automataNotifier.state = {
        'states': states,
        'alphabet': alphabet,
        'table': table,
      };
    }

    state = state.copyWith(
      result: response?['result'] ?? '',
      resultValidation: response?['error'] ?? '',
      exception: response?['exception'] ?? '',
    );
  }
}
