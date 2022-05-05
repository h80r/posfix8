import 'package:alfred/alfred.dart';

import 'models/state.dart';
import 'postfixing/expression_conversion.dart';
import 'automaton/expression_execution.dart';

var testNumber = 0;

Map<String, dynamic> test(String input, {String? expected}) {
  print('Teste ${testNumber++}: $input');

  final result = infixToPostfix(input);
  print('\t-> Resposta: $result');
  if (expected != null) {
    print('\t-> Esperado: $expected [${expected == result ? '✓' : '✗'}]');
  }

  if (result == null) return {'exception': 'Disparidade de parênteses'};

  final automaton = executeExpression(result);
  final isValid = automaton is State;
  print('\t-> Validação: Expressão ${isValid ? 'válida' : 'inválida'}');

  return {
    'result': result,
    'automaton': isValid ? automaton.toJson() : automaton,
  };
}

void main() async {
  final app = Alfred();

  app.post('/', (req, res) async {
    final body = await req.bodyAsJsonMap;

    final expression = body['expression'] as String;
    final expected = body['expected'] as String?;

    return test(
      expression,
      expected: expected?.isEmpty ?? true ? null : expected,
    );
  });

  await app.listen(8010);
}
