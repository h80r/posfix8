import 'package:client/schema/automata_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final automataProvider = StateProvider<AutomataState>((ref) {
  return AutomataState.initial();
});
