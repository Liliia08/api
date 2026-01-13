import 'api_service.dart';
import 'package:api/matule_shop/src/product.dart';
import 'package:api/matule_shop/src/news.dart';

class ShopService {
  final ApiService _api;

  ShopService(this._api);

  // 4. Получение акций
  Future<List<News>> getNews() async {
    final response = await _api.get('/collections/news/records');
    final items = response['items'] as List? ?? [];
    return items.map((json) => News.fromJson(json)).toList();
  }

  // 5. Получение каталога
  Future<List<Product>> getCatalog() async {
    final response = await _api.get('/collections/products/records');
    final items = response['items'] as List? ?? [];
    return items.map((json) => Product.fromJson(json)).toList();
  }

  // 6. Поиск
  Future<List<Product>> search(String query) async {
    final response = await _api.get(
      '/collections/products/records?filter=(title ?~ "$query")',
    );
    final items = response['items'] as List? ?? [];
    return items.map((json) => Product.fromJson(json)).toList();
  }

  // 7. Получение описания товара
  Future<Product> getProductDetails(String productId) async {
    final response = await _api.get('/collections/products/records/$productId');
    return Product.fromJson(response);
  }
}