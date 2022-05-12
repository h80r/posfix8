import 'package:client/provider/automata.dart';
import 'package:client/schema/automata_state.dart';
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

    _automataNotifier.state = AutomataState.fromJson(response?['automaton']);

    state = state.copyWith(
      result: response?['result'],
      resultValidation: response?['isValid'],
      exception: response?['exception'],
    );
  }
}
