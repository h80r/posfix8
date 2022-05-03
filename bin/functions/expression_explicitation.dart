import '../models.dart';

String explicitConcatenation(Symbol currentSymbol, String remainingInput) {
  if (remainingInput.isEmpty) return remainingInput;

  final next = Symbol.read(remainingInput);

  switch (currentSymbol.runtimeType) {
    case Operand:
      if (next is Operand || next.value == '(') {
        return '.' + remainingInput;
      }
      break;
    case Operator:
      if (currentSymbol.value != '*') break;
      if (next is Operand || next.value == '(') {
        return '.' + remainingInput;
      }
      break;
    case Parenthesis:
      if (currentSymbol.value != ')') break;
      if (next is Operand || next.value == '(') {
        return '.' + remainingInput;
      }
      break;
  }

  return remainingInput;
}
