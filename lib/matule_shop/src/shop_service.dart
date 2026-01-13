import 'models.dart';
import 'api_client.dart';

/// Сервис для работы с магазином
class ShopService {
  final ApiClient _client;

  ShopService({required String baseUrl})
      : _client = ApiClient(baseUrl: baseUrl);

  /// Получить список новостей
  Future<List<News>> getNews() async {
    final response = await _client.get('collections/news/records');
    final items = response['items'] as List? ?? [];

    return items.map((item) {
      return News.fromJson(item as Map<String, dynamic>);
    }).toList();
  }

  /// Получить список товаров
  Future<List<Product>> getProducts({
    String? search,
    String? category,
  }) async {
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

    final items = response['items'] as List? ?? [];

    return items.map((item) {
      return Product.fromJson(item as Map<String, dynamic>);
    }).toList();
  }

  /// Получить детали товара
  Future<Product> getProductDetail(String productId) async {
    final response = await _client.get(
      'collections/products/records/$productId',
    );

    return Product.fromJson(response);
  }

  /// Авторизация пользователя
  Future<User> login(String email, String password) async {
    final response = await _client.post(
      'collections/users/auth-with-password',
      body: {
        'identity': email,
        'password': password,
      },
    );

    final user = User.fromJson(response);

    // Сохраняем токен для будущих запросов
    if (user.token != null) {
      _client.setToken(user.token!);
    }

    return user;
  }

  /// Регистрация пользователя
  Future<User> register(String email, String password) async {
    final response = await _client.post(
      'collections/users/records',
      body: {
        'email': email,
        'password': password,
        'passwordConfirm': password,
      },
    );

    return User.fromJson(response);
  }

  /// Установить токен авторизации (если уже есть)
  void setAuthToken(String token) {
    _client.setToken(token);
  }
}