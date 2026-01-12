/// Сервис для работы с магазином
import 'models.dart';
import 'api_client.dart';

class ShopService {
  final ApiClient _client;

  ShopService({required String baseUrl})
      : _client = ApiClient(baseUrl: baseUrl);

  /// Получить список новостей
  Future<List<News>> getNews() async {
    try {
      final response = await _client.get('collections/news/records');
      final items = response['items'] as List?;

      if (items == null) return [];

      return items.map((item) {
        return News.fromJson(item as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Ошибка загрузки новостей: $e');
      return [];
    }
  }

  /// Получить список товаров
  Future<List<Product>> getProducts({
    String? search,
    String? category,
    int limit = 10,
  }) async {
    try {
      final Map<String, String> queryParams = {};

      if (search != null && search.isNotEmpty) {
        queryParams['filter'] = "(title~'$search')";
      }

      if (category != null && category.isNotEmpty) {
        queryParams['filter'] = "(typeCloses='$category')";
      }

      queryParams['perPage'] = limit.toString();

      final response = await _client.get(
        'collections/products/records',
        queryParams: queryParams,
      );

      final items = response['items'] as List?;

      if (items == null) return [];

      return items.map((item) {
        return Product.fromJson(item as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Ошибка загрузки товаров: $e');
      return [];
    }
  }

  /// Получить детали товара по ID
  Future<Product?> getProductDetail(String productId) async {
    try {
      final response = await _client.get(
        'collections/products/records/$productId',
      );
      return Product.fromJson(response);
    } catch (e) {
      print('Ошибка загрузки деталей товара: $e');
      return null;
    }
  }
}