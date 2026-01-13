/// Библиотека API для Matule магазина
library matule_api;

// Экспортируем публичные классы
export 'src/models.dart' show Product, News, User;
export 'src/shop_service.dart' show ShopService;
// ApiClient не экспортируем - он внутренний