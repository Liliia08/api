import 'api_service.dart';
import 'package:api/matule_shop/src/user_model.dart';

class AuthService {
  final ApiService _api;

  AuthService(this._api);

  // 1. Авторизация
  Future<void> login(String email, String password) async {
    final response = await _api.post(
      '/collections/users/auth-with-password',
      {
        'identity': email,
        'password': password,
      },
    );

    _api.setToken(response['token']);
  }

  // 2. Создание пользователя
  Future<void> register(String email, String password) async {
    await _api.post(
      '/collections/users/records',
      {
        'email': email,
        'password': password,
        'passwordConfirm': password,
      },
    );
  }

  // 13. Получение информации о профиле
  Future<User> getProfile(String userId) async {
    final response = await _api.get('/collections/users/records/$userId');
    return User.fromJson(response);
  }

  // 14. Выход
  void logout() {
    _api.clearToken();
  }
}