class State {
  State()
      : children = {},
        displayed = false,
        id = globalId++,
        _closure = null,
        isInitial = false,
        isFinal = false {
    finalState = this;
  }

  static var globalId = 0;

  final int id;
  final Map<String, List<State>> children;

  late State finalState;
  bool displayed;

  List<State>? _closure;

  bool isInitial;
  bool isFinal;

  void addChild(String key, State value) {
    children[key] = [...?children[key], value];
  }

  void reset() {
    if (!displayed) return;

    displayed = false;

    children.forEach((key, value) {
      for (final child in value) {
        child.reset();
      }
    });
  }

  List<State> get closure {
    if (_closure != null) return _closure!;
    calculateClosures();
    return _closure!;
  }

  List<State> allStates() {
    final states = [this];
    if (isFinal) return states;

    for (final child in children.values.expand((value) => value)) {
      child._stateListing(states);
    }

    return states;
  }

  void _stateListing(List<State> states) {
    if (states.contains(this)) return;

    states.add(this);

    for (final child in children.values.expand((value) => value)) {
      child._stateListing(states);
    }
  }

  void calculateClosures() {
    if (_closure != null) return;

    _closure = [this];
    final states = children['ε'];
    if (states == null) return;
    for (final state in states) {
      _closure!.addAll(state.closure);
    }
  }

  @override
  String toString() {
    return '${isInitial ? '>' : isFinal ? '*' : ''}$id';
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is State && other.id == id;
}
