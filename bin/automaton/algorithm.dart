import '../models/state.dart';

State base(String key) {
  final qf = State();

  return State()
    ..addChild(key, qf)
    ..finalState = qf;
}

State concatenation(State a, State b) => a
  ..finalState.addChild('ε', b)
  ..finalState = b.finalState;

State union(State a, State b) {
  final q0 = State()
    ..addChild('ε', a)
    ..addChild('ε', b);

  final qf = State();
  a.finalState.addChild('ε', qf);
  b.finalState.addChild('ε', qf);

  return q0..finalState = qf;
}

State kleene(State a) {
  final qf = State();

  final q0 = State()
    ..addChild('ε', a)
    ..addChild('ε', qf);

  a.finalState
    ..addChild('ε', qf)
    ..addChild('ε', a);

  return q0..finalState = qf;
}
