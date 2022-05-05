import 'dart:convert';

import 'models/state.dart';

final globalDecoder = JsonDecoder();
final globalEncoder = JsonEncoder.withIndent('  ');

void log(State input) {
  final obj = globalDecoder.convert(input.toString());
  final result = globalEncoder.convert(obj);
  result.split('\n').forEach((e) => print(e));
}
