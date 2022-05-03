import 'package:stack/stack.dart';

import '../models.dart';

bool isValidExpression(String input) => _recursion(Stack(), input);

bool _recursion(Stack<Symbol> stack, String input) {
  if (input.isEmpty) {
    final result = stack.pop();
    return stack.isEmpty;
  }

  final symbol = Symbol.read(input);
  input = input.substring(symbol.value.length);

  if (symbol is Operand) {
    stack.push(symbol);

    return _recursion(stack, input);
  }

  if (stack.isEmpty) {
    print('Unhandled exception');
    return false;
  }

  final op2 = stack.pop();

  if ((symbol as Operator).isUnary) {
    final value = symbol.apply(op2 as Operand);
    stack.push(value);

    return _recursion(stack, input);
  }

  if (stack.isEmpty) {
    print('Exception: Binary operator with single operand');
    return false;
  }

  final op1 = stack.pop();
  final value = symbol.apply(op2 as Operand, op1 as Operand);
  stack.push(value);

  return _recursion(stack, input);
}
