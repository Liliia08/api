import 'models.dart';
import 'api_client.dart';

class ShopService {
  final ApiClient _client;

  ShopService({required String baseUrl})
      : _client = ApiClient(baseUrl: baseUrl);

  Future<List<News>> getNews() async {
    try {
      final response = await _client.get('collections/news/records');
      final dynamic items = response['items'];

      if (items == null || items is! List) return [];

      return List<News>.from(
          (items as List).map((item) => News.fromJson(item as Map<String, dynamic>))
      );
    } catch (e) {
      print('Ошибка загрузки новостей: $e');
      rethrow;
    }
  }

  Future<List<Product>> getProducts({
    String? search,
    String? category,
  }) async {
    try {
      final Map<String, String> queryParams = {};

      if (search != null && search.isNotEmpty) {
        queryParams['filter'] = "(title~'$search')";
      }

      if (category != null && category.isNotEmpty) {
        queryParams['filter'] = "(typeCloses='$category')";
      }

      final response = await _client.get(
        'collections/products/records',
        queryParams: queryParams.isNotEmpty ? queryParams : null,
      );

      final dynamic items = response['items'];

      if (items == null || items is! List) return [];

      return List<Product>.from(
          (items as List).map((item) => Product.fromJson(item as Map<String, dynamic>))
      );
    } catch (e) {
      print('Ошибка загрузки товаров: $e');
      rethrow;
    }
  }

  void setAuthToken(String token) {
    _client.setToken(token);
  }
}