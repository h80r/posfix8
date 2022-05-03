import 'package:stack/stack.dart';

import '../models.dart';

String? isValidExpression(String input) => _recursion(Stack(), input);

String? _recursion(Stack<Symbol> stack, String input) {
  if (input.isEmpty) {
    if (stack.isEmpty) return 'Erro não Identificado';
    final result = stack.pop();
    return stack.isEmpty ? null : 'Erro Não Identificado';
  }

  final symbol = Symbol.read(input);
  input = input.substring(symbol.value.length);

  if (symbol is Operand) {
    stack.push(symbol);

    return _recursion(stack, input);
  }

  if (stack.isEmpty) {
    return 'Erro não identificado';
  }

  final op2 = stack.pop();

  if ((symbol as Operator).isUnary) {
    final value = symbol.apply(op2 as Operand);
    stack.push(value);

    return _recursion(stack, input);
  }

  if (stack.isEmpty) {
    return 'Operador binário sem segundo operando';
  }

  final op1 = stack.pop();
  final value = symbol.apply(op2 as Operand, op1 as Operand);
  stack.push(value);

  return _recursion(stack, input);
}
