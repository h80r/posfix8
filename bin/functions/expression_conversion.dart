import 'package:stack/stack.dart';

import '../models.dart';
import 'expression_explicitation.dart';

String infixToPostfix(String input) =>
    _recursion(input.replaceAll(' ', ''), '', Stack());

String _recursion(String input, String result, Stack<Symbol> stack) {
  if (input.isEmpty) {
    if (stack.isEmpty) return result;
    return _recursion(input, result + stack.pop().value, stack);
  }

  final symbol = Symbol.read(input);
  input = explicitConcatenation(symbol, input.substring(symbol.value.length));

  if (symbol is Operand) {
    return _recursion(input, result + symbol.value, stack);
  }

  if (symbol is Parenthesis) {
    if (symbol.isOpen) {
      return _recursion(input, result, stack..push(symbol));
    }

    while (true) {
      final top = stack.pop();

      if (top is Parenthesis && top.isOpen) break;

      result += top.value;
    }

    return _recursion(input, result, stack);
  }

  while (stack.isNotEmpty) {
    final top = stack.top();
    if (top is! Operator) break;
    if (top.precedence < (symbol as Operator).precedence) break;

    result += stack.pop().value;
  }

  return _recursion(input, result, stack..push(symbol));
}
