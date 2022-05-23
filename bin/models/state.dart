class State {
  State()
      : children = {},
        displayed = false,
        id = globalId++,
        _closure = null {
    finalState = this;
  }

  static var globalId = 0;

  final int id;
  final Map<String, List<State>> children;

  late State finalState;
  bool displayed;

  List<State>? _closure;

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

  void calculateClosures() {
    if (_closure != null) return;

    _closure = [this];
    final states = children['ε'];
    if (states == null) return;
    for (final state in states) {
      _closure!.addAll(state.closure);
    }
  }

  Map<String, dynamic> toJson() {
    if (displayed) return {'stateId': id};
    displayed = true;

    final transitions = children.map(
      (k, v) => MapEntry(k, v.map((s) => s.toJson()).toList()),
    );

    return {'stateId': id, 'transitions': transitions};
  }
}
