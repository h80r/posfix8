import 'package:test/test.dart';

import 'functions/expression_conversion.dart';

void main() {
  group('[NA] Revisão de expressões regulares:', () {
    test('(a+b)*(aa+bb)', () {
      expect(infixToPostfix('(a+b)*(aa+bb)'), 'ab+*aa.bb.+.');
    });
    test('(a*b*)* ', () {
      expect(infixToPostfix('(a*b*)*'), 'a*b*.*');
    });
    test('(b*ab*ab*)(b*ab*ab*)*', () {
      expect(infixToPostfix('(b*ab*ab*)(b*ab*ab*)*'),
          'b*a.b*.a.b*.b*a.b*.a.b*.*.');
    });
  });

  group('[NA] De notação infixa para posfixa:', () {
    test('((aa)* (ab+ba)(bb)*a(a+b))*', () {
      expect(infixToPostfix('((aa)* (ab+ba)(bb)*a(a+b))*'),
          'aa.*ab.ba.+.bb.*.a.ab+.*');
    });
    test('( A + B ) * ( C . D )', () {
      expect(infixToPostfix('( A + B ) * ( C . D )'), 'AB+*CD..');
    });
    test('A + B * C', () {
      expect(infixToPostfix('A + B * C'), 'AB*C.+');
    });
    test('( A + B ) * C', () {
      expect(infixToPostfix('( A + B ) * C'), 'AB+*C.');
    });
  });

  group('[A] Testes de parênteses:', () {
    test('((aa) * (ab)+(ba)((bb)*a(a+b))', () {
      expect(infixToPostfix('((aa) * (ab)+(ba)((bb)*a(a+b))'), null);
    });
    test('aa()', () {
      expect(infixToPostfix('aa()'), 'aa..');
    });
    test('a)(b', () {
      expect(infixToPostfix('a)(b'), null);
    });
  });
}
