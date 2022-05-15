import '../models/state.dart';

extension TableGeneration on State {
  Map<String, Map<String, List<String>>> toTable() {
    reset();

    final table = <String, Map<String, List<String>>>{};
    _lineGeneration(table);

    reset();

    final lastState = table[finalState.id.toString()]!;
    table.remove(finalState.id.toString());

    final namedTable = table.map((key, value) => MapEntry('q$key', value));
    namedTable.addEntries([MapEntry('*q${finalState.id}', lastState)]);

    return namedTable;
  }

  void _lineGeneration(Map<String, Map<String, List<String>>> table) {
    if (displayed) return;

    table['$id'] = children.map(
      (k, v) => MapEntry(k, v.map((s) => 'q${s.id}').toList()),
    );
    displayed = true;

    children.forEach((key, value) {
      for (final child in value) {
        child._lineGeneration(table);
      }
    });
  }
}
