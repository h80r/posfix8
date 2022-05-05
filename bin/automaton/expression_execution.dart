import 'package:stack/stack.dart';

import '../models/state.dart';
import '../models/symbol.dart';

dynamic executeExpression(String input) => _recursion(Stack(), input);

dynamic _recursion(Stack<State> stack, String input) {
  if (input.isEmpty) {
    if (stack.isEmpty) return 'Erro não Identificado';

    final result = stack.pop();

    return stack.isEmpty ? result : 'Erro Não Identificado';
  }

  final symbol = Symbol.read(input);
  input = input.substring(symbol.value.length);

  if (symbol is Operand) {
    return _recursion(stack..push(symbol.automaton()), input);
  }

  if (stack.isEmpty) {
    return 'Erro não identificado';
  }

  final op2 = stack.pop();

  if ((symbol as Operator).isUnary) {
    return _recursion(stack..push(symbol.apply(op2)), input);
  }

  if (stack.isEmpty) {
    return 'Operador binário sem segundo operando';
  }

  stack.push(symbol.apply(op2, stack.pop()));
  return _recursion(stack, input);
}
