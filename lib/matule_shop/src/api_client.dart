import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Базовый HTTP клиент для работы с API
class ApiClient {
  final String baseUrl;
  String? _token;

  ApiClient({required this.baseUrl});

  /// Установить токен авторизации
  void setToken(String token) {
    _token = token;
  }

  /// Получить заголовки запроса
  Map<String, String> _getHeaders() {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (_token != null && _token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_token';
    }

    return headers;
  }

  /// GET запрос
  Future<Map<String, dynamic>> get(
      String endpoint, {
        Map<String, String>? queryParams,
      }) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpoint').replace(
        queryParameters: queryParams,
      );

      final response = await http.get(
        uri,
        headers: _getHeaders(),
      );

      return _handleResponse(response);
    } on SocketException {
      throw Exception('Нет подключения к интернету');
    } on HttpException {
      throw Exception('Ошибка HTTP запроса');
    } catch (e) {
      throw Exception('Ошибка: $e');
    }
  }

  /// POST запрос
  Future<Map<String, dynamic>> post(
      String endpoint, {
        Map<String, dynamic>? body,
      }) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpoint');

      final response = await http.post(
        uri,
        headers: _getHeaders(),
        body: body != null ? jsonEncode(body) : null,
      );

      return _handleResponse(response);
    } on SocketException {
      throw Exception('Нет подключения к интернету');
    } on HttpException {
      throw Exception('Ошибка HTTP запроса');
    } catch (e) {
      throw Exception('Ошибка: $e');
    }
  }

  /// Обработка ответа сервера
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 401) {
      throw Exception('Требуется авторизация');
    } else if (response.statusCode == 404) {
      throw Exception('Ресурс не найден');
    } else {
      throw Exception(
        'Ошибка сервера ${response.statusCode}: ${response.body}',
      );
    }
  }
}