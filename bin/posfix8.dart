import 'package:alfred/alfred.dart';

import 'functions/expression_conversion.dart';
import 'functions/expression_validation.dart';

var testNumber = 0;

Map<String, dynamic> test(String input, {String? expected}) {
  print('Teste ${testNumber++}: $input');

  final result = infixToPostfix(input);
  print('\t-> Resposta: $result');

  if (result == null) return {'exception': 'Disparidade de parênteses'};

  if (expected != null) {
    print('\t-> Esperado: $expected [${expected == result ? '✓' : '✗'}]');
  }

  final isValid = isValidExpression(result);
  print('\t-> Validação: Expressão ${isValid ? 'válida' : 'inválida'}');

  return {'result': result, 'isValid': isValid};
}

void main() async {
  final app = Alfred();

  app.post('/', (req, res) async {
    final body = await req.bodyAsJsonMap;

    final expression = body['expression'] as String;
    final expected = body['expected'] as String?;

    return test(expression, expected: expected);
  });

  await app.listen(8010);
}
