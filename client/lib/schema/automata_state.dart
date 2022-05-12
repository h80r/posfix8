class AutomataState {
  AutomataState(this.id, this.children);

  AutomataState.initial() : this(-1, {});

  final int id;
  final Map<String, List<AutomataState>> children;
  var displayed = false;

  void reset() {
    if (!displayed) return;

    displayed = false;

    children.forEach((key, value) {
      for (final child in value) {
        child.reset();
      }
    });
  }

  AutomataState.fromJson(Map<String, dynamic> json)
      : id = json['stateId'],
        children = (json['transitions'] as Map<String, dynamic>?)
                ?.cast<String, List>()
                .map(
                  (key, value) => MapEntry(
                    key,
                    value
                        .cast<Map<String, dynamic>>()
                        .map(AutomataState.fromJson)
                        .toList(),
                  ),
                ) ??
            {};
}
