import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../automata.dart';

class TransitionNotifier extends StateNotifier<Map<String, Color>> {
  TransitionNotifier(this._automata, this._kGoldenAngle) : super({}) {
    loadAutomata();
  }

  final Map<String, dynamic> _automata;
  final double _kGoldenAngle;

  static final provider =
      StateNotifierProvider<TransitionNotifier, Map<String, Color>>((ref) {
    return TransitionNotifier(ref.watch(automataProvider), 180 * (3 - sqrt(5)));
  });

  void loadAutomata() {
    final alphabet = _automata['alphabet'] as List<String>;

    for (var j = 0; j < alphabet.length; j++) {
      final symbol = alphabet[j];
      _setColor(symbol);
    }
  }

  void _setColor(String id) {
    if (state.containsKey(id)) return;

    final color = HSLColor.fromAHSL(
      1.0,
      (state.length * _kGoldenAngle) % 360.0,
      1.0,
      0.75,
    ).toColor();

    state = {...state, id: color};
  }
}
