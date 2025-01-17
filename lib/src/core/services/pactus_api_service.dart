import 'package:dio/dio.dart';

class PactusApiService {
  final Dio _dio;
  final String baseUrl;

  PactusApiService({String? baseUrl})
      : baseUrl = baseUrl ?? 'http://127.0.0.1:8080',
        _dio = Dio() {
    _dio.options.baseUrl = this.baseUrl;
  }

  Future<bool> isDaemonRunning() async {
    try {
      final response = await _dio.get('/status');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> getNodeInfo() async {
    try {
      final response = await _dio.get('/node/info');
      return response.data;
    } catch (e) {
      throw Exception('Failed to get node info: $e');
    }
  }

  Future<Map<String, dynamic>> getBalance(String address) async {
    try {
      final response = await _dio.get('/account/balance/$address');
      return response.data;
    } catch (e) {
      throw Exception('Failed to get balance: $e');
    }
  }

  Future<Map<String, dynamic>> sendTransaction({
    required String from,
    required String to,
    required String amount,
  }) async {
    try {
      final response = await _dio.post('/transaction/send', data: {
        'from': from,
        'to': to,
        'amount': amount,
      });
      return response.data;
    } catch (e) {
      throw Exception('Failed to send transaction: $e');
    }
  }
} 