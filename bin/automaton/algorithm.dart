import '../models/state.dart';

State base(String key) {
  final qf = State()..isFinal = true;

  return State()
    ..isInitial = true
    ..addChild(key, qf)
    ..finalState = qf;
}

State concatenation(State a, State b) {
  a.finalState.isFinal = false;
  b.isInitial = false;

  return a
    ..finalState.addChild('ε', b)
    ..finalState = b.finalState;
}

State union(State a, State b) {
  a.isInitial = false;
  a.finalState.isFinal = false;
  b.isInitial = false;
  b.finalState.isFinal = false;

  final q0 = State()
    ..isInitial = true
    ..addChild('ε', a)
    ..addChild('ε', b);

  final qf = State()..isFinal = true;
  a.finalState.addChild('ε', qf);
  b.finalState.addChild('ε', qf);

  return q0..finalState = qf;
}

State kleene(State a) {
  final qf = State()..isFinal = true;
  a.isInitial = false;
  a.finalState.isFinal = false;

  final q0 = State()
    ..isInitial = true
    ..addChild('ε', a)
    ..addChild('ε', qf);

  a.finalState
    ..addChild('ε', qf)
    ..addChild('ε', a);

  return q0..finalState = qf;
}
