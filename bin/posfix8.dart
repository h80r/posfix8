import 'functions/expression_conversion.dart';
import 'functions/expression_validation.dart';

var testNumber = 0;

void test(String input, {String? expected}) {
  print('Teste ${testNumber++}: $input');

  final result = infixToPostfix(input);
  print('\t-> Resposta: $result');

  if (expected != null) {
    print('\t-> Esperado: $expected [${expected == result ? '✓' : '✗'}]');
  }

  final isValid = isValidExpression(result);
  print('\t-> Validação: Expressão ${isValid ? 'válida' : 'inválida'}');
}

void main(List<String> arguments) {
  test('((aa)* (ab+ba)(bb)*a(a+b))*', expected: 'aa.*ab.ba.+.bb.*.a.ab+.*');
  test('( 5 + 9 ) * 2 + 6 * 5', expected: '59+*2.6*5.+');
  // print(infixToPostfix(r'\.\.'));
}
