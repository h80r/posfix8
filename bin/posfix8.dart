// import 'package:alfred/alfred.dart';

import 'algorithm.dart';
import 'postfixing/expression_conversion.dart';
import 'postfixing/expression_validation.dart';
import 'utils.dart';

var testNumber = 0;

Map<String, dynamic> test(String input, {String? expected}) {
  print('Teste ${testNumber++}: $input');

  final result = infixToPostfix(input);
  print('\t-> Resposta: $result');

  if (result == null) return {'exception': 'Disparidade de parênteses'};

  final isValid = isValidExpression(result);

  if (expected != null) {
    print('\t-> Esperado: $expected [${expected == result ? '✓' : '✗'}]');
  }
  print('\t-> Validação: Expressão ${isValid == null ? 'válida' : 'inválida'}');

  return {'result': result, 'isValid': isValid};
}

void main() {
  final s1 = base('a');
  final s2 = base('b');
  final s3 = union(s1, s2);
  final s4 = kleene(s3);
  final s5 = base('a');
  final s6 = concatenation(s4, s5);
  log(s6);
}

// void main() async {
//   final app = Alfred();

//   app.post('/', (req, res) async {
//     final body = await req.bodyAsJsonMap;

//     final expression = body['expression'] as String;
//     final expected = body['expected'] as String?;

//     return test(
//       expression,
//       expected: expected?.isEmpty ?? true ? null : expected,
//     );
//   });

//   await app.listen(8010);
// }
