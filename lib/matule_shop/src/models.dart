/// Модели данных API

class Product {
  final String id;
  final String title;
  final int price;
  final String? description;
  final String? typeCloses;
  final String? imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.description,
    this.typeCloses,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Без названия',
      price: (json['price'] as num?)?.toInt() ?? 0,
      description: json['description']?.toString(),
      typeCloses: json['typeCloses']?.toString(),
      imageUrl: json['image_url']?.toString() ?? json['imageUrl']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'typeCloses': typeCloses,
    'imageUrl': imageUrl,
  };
}

class News {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;

  News({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Новость',
      description: json['description']?.toString(),
      imageUrl: json['image_url']?.toString() ?? json['imageUrl']?.toString(),
    );
  }
}

/// Модель пользователя (для авторизации)
class User {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? token;

  User({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? json['record']['id']?.toString() ?? '',
      email: json['email']?.toString() ?? json['record']['email']?.toString() ?? '',
      firstName: json['firstname']?.toString(),
      lastName: json['lastname']?.toString(),
      token: json['token']?.toString(),
    );
  }
}