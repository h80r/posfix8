import '../models/state.dart';

extension ClosureGeneration on State {
  Map<String, dynamic> toClosureTable() {
    final map = <String, List<String>>{};

    _lineGeneration(map);

    return map;
  }

  void _lineGeneration(Map<String, List<String>> map) {
    if (displayed) return;

    map['$id'] = closure.map((e) => e.id.toString()).toList();
    displayed = true;

    children.forEach((key, value) {
      for (final child in value) {
        child._lineGeneration(map);
      }
    });
  }
}
