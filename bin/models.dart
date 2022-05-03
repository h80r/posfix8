class Symbol {
  const Symbol(this.value);

  final String value;

  factory Symbol.read(String input) {
    final value = input[0] == r'\' ? input.substring(0, 2) : input[0];

    if (['.', '*', '+'].contains(value)) return Operator(value);
    if (['(', ')'].contains(value)) return Parenthesis(value);
    return Operand(value);
  }

  @override
  String toString() => 'Symbol(value: $value)';
}

class Operator extends Symbol {
  Operator(String value) : super(value) {
    isUnary = value == '*';
    precedence = {'+': 1, '.': 2, '*': 3}[value] ?? 0;
  }

  late final bool isUnary;
  late final int precedence;

  Symbol apply(Operand firstOperating, [Operand? secondOperating]) {
    if (secondOperating != null) {
      return Operand(firstOperating.value + secondOperating.value);
    } // TODO: Apply binary operations

    return firstOperating; // TODO: Apply unary operations
  }
}

class Operand extends Symbol {
  const Operand(String value) : super(value);
}

class Parenthesis extends Symbol {
  const Parenthesis(String value) : super(value);

  bool get isOpen => value == '(';
}
