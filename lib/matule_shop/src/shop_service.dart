// Сервис магазина

import 'models.dart';
import 'api_client.dart';

class ShopService {
  final ApiClient _client;

  ShopService({required String baseUrl})
      : _client = ApiClient(baseUrl: baseUrl);

  // 3.1 Акции и новости
  Future<List<News>> getNews() async {
    try {
      final response = await _client.get('collections/news/records');
      final items = response['items'] as List?;

      if (items == null) return [];

      return items.map((item) => News.fromJson(item)).toList();
    } catch (e) {
      print('Error loading news: $e');
      return [];
    }
  }

  // 3.2 Список товаров с поиском
  Future<List<Product>> getProducts({
    String? search,
    String? category,
  }) async {
    try {
      final Map<String, String> queryParams = {};

      if (search != null && search.isNotEmpty) {
        queryParams['filter'] = "(title ?~ '$search')";
      }

      if (category != null && category.isNotEmpty) {
        queryParams['filter'] = "(typeCloses = '$category')";
      }

      final response = await _client.get(
        'collections/products/records',
        queryParams: queryParams,
      );

      final items = response['items'] as List?;
      if (items == null) return [];

      return items.map((item) => Product.fromJson(item)).toList();
    } catch (e) {
      print('Error loading products: $e');
      return [];
    }
  }

  // 3.3 Детали товара
  Future<Product?> getProductDetail(String productId) async {
    try {
      final response = await _client.get(
        'collections/products/records/$productId',
      );
      return Product.fromJson(response);
    } catch (e) {
      print('Error loading product details: $e');
      return null;
    }
  }

  // Установить токен (для защищенных запросов)
  void setAuthToken(String token) {
    _client.setToken(token);
  }
}