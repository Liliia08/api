import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://api.matule.ru/api';
  String? _token;

  String? get token => _token;
  void setToken(String token) => _token = token;
  void clearToken() => _token = null;

  Map<String, String> _getHeaders() {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  Future<Map<String, dynamic>> _request(
      String method,
      String endpoint, [
        Map<String, dynamic>? data,
      ]) async {
    try {
      final url = Uri.parse('$_baseUrl$endpoint');
      final headers = _getHeaders();

      http.Response response;

      switch (method) {
        case 'GET':
          response = await http.get(url, headers: headers);
          break;
        case 'POST':
          response = await http.post(
            url,
            headers: headers,
            body: json.encode(data),
          );
          break;
        case 'PATCH':
          response = await http.patch(
            url,
            headers: headers,
            body: json.encode(data),
          );
          break;
        case 'DELETE':
          response = await http.delete(url, headers: headers);
          break;
        default:
          throw Exception('Неизвестный метод: $method');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isNotEmpty) {
          return json.decode(response.body) as Map<String, dynamic>;
        }
        return {};
      } else {
        throw Exception('Ошибка ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Сетевая ошибка: $e');
    }
  }

  // Методы для удобства
  Future<Map<String, dynamic>> get(String endpoint) => _request('GET', endpoint);
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) =>
      _request('POST', endpoint, data);
  Future<Map<String, dynamic>> patch(String endpoint, Map<String, dynamic> data) =>
      _request('PATCH', endpoint, data);
}