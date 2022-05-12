import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:client/schema/home.dart';

import '../services.dart';

class HomeNotifier extends StateNotifier<HomeSchema> {
  HomeNotifier(this._services) : super(HomeSchema.initial());

  final ServicesProvider _services;

  static final provider = StateNotifierProvider<HomeNotifier, HomeSchema>(
    (ref) => HomeNotifier(ref.watch(ServicesProvider.provider)),
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

    state = state.copyWith(
      result: response?['result'],
      resultValidation: response?['isValid'],
      exception: response?['exception'],
    );
  }
}
