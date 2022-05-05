class State {
  State()
      : children = {},
        finalState = null,
        displayed = false,
        id = globalId++;

  static var globalId = 0;
  final int id;

  Map<String, List<State>> children;
  State? finalState;
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
