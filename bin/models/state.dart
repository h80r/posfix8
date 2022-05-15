class State {
  State()
      : children = {},
        displayed = false,
        id = globalId++ {
    finalState = this;
  }

  static var globalId = 0;

  final int id;
  final Map<String, List<State>> children;

  late State finalState;
  bool displayed;

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

  Map<String, dynamic> toJson() {
    if (displayed) return {'stateId': id};
    displayed = true;

    final transitions = children.map(
      (k, v) => MapEntry(k, v.map((s) => s.toJson()).toList()),
    );

    return {'stateId': id, 'transitions': transitions};
  }
}
