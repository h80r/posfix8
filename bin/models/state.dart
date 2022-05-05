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

  @override
  String toString() {
    if (displayed) return '{"stateId" : $id}';
    displayed = true;

    final parsedChildren = children.entries
        .map((e) =>
            '"${e.key}": [${e.value.map((q) => q.toString()).join(', ')}]')
        .join(', ');
    return '{"stateId" : $id, "transitions": {$parsedChildren}}';
  }
}
