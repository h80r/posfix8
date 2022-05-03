import 'package:dio/dio.dart';

class Services {
  Services._();

  static final _api = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8010'));

  static Future<Map<String, dynamic>?> get(
    String expression,
    String? expected,
  ) async {
    final response = await _api.post('/', data: {
      'expression': expression,
      'expected': expected,
    });

    return response.data;
  }
}
