import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  String? _token;

  ApiClient({required this.baseUrl});

  // Установить токен авторизации
  void setToken(String token) {
    _token = token;
  }

  // Получить заголовки
  Map<String, String> _getHeaders() {
    final headers = {'Content-Type': 'application/json'};
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  // GET запрос
  Future<Map<String, dynamic>> get(
      String endpoint, {
        Map<String, String>? queryParams,
      }) async {
    final uri = Uri.parse('$baseUrl/$endpoint').replace(
      queryParameters: queryParams,
    );

    print('[API GET] $uri'); // Для отладки

    final response = await http.get(
      uri,
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'API Error ${response.statusCode}: ${response.body}',
      );
    }
  }
}