import 'package:stack/stack.dart';

import '../models/state.dart';
import 'table_generation.dart';

extension DFAConversion on State {
  Map<String, dynamic> toDFATable() {
    final alphabet = (toTable()['alphabet'] as List<String>)..remove('ε');

    final statesToProcess = Stack<List<State>>();
    final processedStates = Stack<List<State>>();
    statesToProcess.push(closure);

    final newTransitions = <Map<String, dynamic>>[];

    while (statesToProcess.isNotEmpty) {
      final currentState = statesToProcess.pop();

      for (final symbol in alphabet) {
        var newState = <State>[];

        for (final state in currentState) {
          state.children[symbol]?.forEach((s) {
            newState.addAll(s.closure);
          });
        }

        newState = newState.toSet().toList();

        if (!_hasCopy(statesToProcess, newState) &&
            !_hasCopy(processedStates, newState) &&
            !_hasCopy(Stack()..push(currentState), newState)) {
          statesToProcess.push(newState);
        }

        newTransitions.add({
          'from': currentState,
          'symbol': symbol,
          'to': newState,
        });
      }

      processedStates.push(currentState);
    }

    var currentId = 0;
    final stateIdMap = <String, String>{};
    for (final transition in newTransitions) {
      final from = transition['from'];
      final to = transition['to'];

      if (!stateIdMap.containsKey(from.toString())) {
        stateIdMap[from.toString()] = '${_getPrefix(from)}q${currentId++}';
      }

      if (!stateIdMap.containsKey(to.toString())) {
        stateIdMap[to.toString()] = '${_getPrefix(to)}q${currentId++}';
      }
    }

    return {
      'states': stateIdMap.values.toList(),
      'alphabet': alphabet,
      'table': [
        for (final state in stateIdMap.entries)
          [
            for (final transition in newTransitions
                .where((element) => element['from'].toString() == state.key))
              stateIdMap[(transition['to'] as List<State>).toString()]
          ]
      ],
    };
  }

  String _getPrefix(List<State> states) {
    final isInitial = states.any((s) => s.isInitial);
    final isFinal = states.any((s) => s.isFinal);
    return '${isInitial ? '>' : ''}${isFinal ? '*' : ''}';
  }

  bool _hasCopy(Stack<List<State>> states, List<State> state) {
    final sortedState = [...state]..sort((a, b) => a.id.compareTo(b.id));
    final backupStack = Stack<List<State>>();

    var result = false;

    while (states.isNotEmpty) {
      final currentState = states.pop();
      final sortedCurrentState = [...currentState]..sort(
          (a, b) => a.id.compareTo(b.id),
        );

      final isSameLength = sortedCurrentState.length == sortedState.length;
      final isSameElements = sortedCurrentState.every(
        (s) => sortedState.contains(s),
      );

      if (isSameElements && isSameLength) {
        result = true;
      }

      backupStack.push(currentState);
    }

    while (backupStack.isNotEmpty) {
      states.push(backupStack.pop());
    }

    return result;
  }
}
