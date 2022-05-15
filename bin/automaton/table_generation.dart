import '../models/state.dart';

extension TableGeneration on State {
  Map<String, dynamic> toTable() {
    reset();

    final map = <String, Map<String, List<String>>>{};
    _lineGeneration(map);

    reset();

    final lastState = map[finalState.id.toString()]!;
    map.remove(finalState.id.toString());

    final namedTable = map.map((key, value) => MapEntry('q$key', value));
    namedTable.addEntries([MapEntry('*q${finalState.id}', lastState)]);

    final states = namedTable.keys.toList();
    final alphabet = namedTable.values.expand((e) => e.keys).toSet().toList();
    final matrix = List.generate(
      states.length,
      (i) => List.generate(
        alphabet.length,
        (j) => namedTable[states[i]]?[alphabet[j]],
      ),
    );

    return {
      'states': states,
      'alphabet': alphabet,
      'table': matrix,
    };
  }

  void _lineGeneration(Map<String, Map<String, List<String>>> map) {
    if (displayed) return;

    map['$id'] = children.map(
      (k, v) => MapEntry(k, v.map((s) => 'q${s.id}').toList()),
    );
    displayed = true;

    children.forEach((key, value) {
      for (final child in value) {
        child._lineGeneration(map);
      }
    });
  }
}
