import 'api_service.dart';
import 'package:api/matule_shop/src/product.dart';
import 'package:api/matule_shop/src/news.dart';

class ShopService {
  final ApiService _api;

  ShopService(this._api);

  // 4. Получение акций
  Future<List<News>> getNews() async {
    try {
      final response = await _api.get('/collections/news/records');

      // Проверяем и преобразуем типы
      final items = response['items'];
      if (items is List) {
        return items
            .whereType<Map<String, dynamic>>() // Фильтруем только Map
            .map((json) => News.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Ошибка загрузки новостей: $e');
    }
  }

  // 5. Получение каталога
  Future<List<Product>> getCatalog() async {
    try {
      final response = await _api.get('/collections/products/records');

      final items = response['items'];
      if (items is List) {
        return items
            .whereType<Map<String, dynamic>>() // Фильтруем только Map
            .map((json) => Product.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Ошибка загрузки каталога: $e');
    }
  }

  // 6. Поиск
  Future<List<Product>> search(String query) async {
    try {
      final response = await _api.get(
        '/collections/products/records?filter=(title ?~ "$query")',
      );

      final items = response['items'];
      if (items is List) {
        return items
            .whereType<Map<String, dynamic>>()
            .map((json) => Product.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Ошибка поиска: $e');
    }
  }

  // 7. Получение описания товара
  Future<Product> getProductDetails(String productId) async {
    try {
      final response = await _api.get('/collections/products/records/$productId');
      return Product.fromJson(response);
    } catch (e) {
      throw Exception('Ошибка загрузки товара: $e');
    }
  }
}