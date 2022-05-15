import 'package:client/provider/automata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:client/schema/canvas/home.dart';

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

    _automataNotifier.state = automaton?.map(
      (key, value) => MapEntry(
        key,
        (value as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            (value as List).cast<String>(),
          ),
        ),
      ),
    );

    state = state.copyWith(
      result: response?['result'] ?? '',
      resultValidation: response?['error'] ?? '',
      exception: response?['exception'] ?? '',
    );
  }
}
