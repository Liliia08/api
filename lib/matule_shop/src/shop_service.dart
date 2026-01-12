import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

class ShopService {
  final String baseUrl;

  ShopService({required this.baseUrl});

  Future<List<Product>> getProducts() async {  // Убрал параметры для простоты
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/collections/products/records?perPage=2'), // Ограничиваем 2 товара
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final items = data['items'] as List? ?? [];

        return items.map((item) {
          return Product.fromJson(item as Map<String, dynamic>);
        }).toList();
      } else {
        print('Ошибка HTTP: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Ошибка API: $e');
      return [];
    }
  }

  Future<List<News>> getNews() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/collections/news/records'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final items = data['items'] as List? ?? [];

        return items.map((item) {
          return News.fromJson(item as Map<String, dynamic>);
        }).toList();
      }
      return [];
    } catch (e) {
      print('Ошибка загрузки новостей: $e');
      return [];
    }
  }
}