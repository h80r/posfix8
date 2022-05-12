import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServicesProvider {
  ServicesProvider(this._api);

  static final provider = Provider<ServicesProvider>((ref) {
    return ServicesProvider(Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8010')));
  });

  final Dio _api;

  Future<Map<String, dynamic>?> get(
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
