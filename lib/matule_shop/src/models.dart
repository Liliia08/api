/// Модели данных для магазина

class Product {
  final String id;
  final String title;
  final String price;  // String для отображения
  final String? typeCloses;
  final String? description;
  final String? imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.typeCloses,
    this.description,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Без названия',
      price: (json['price'] ?? '0').toString(),
      typeCloses: json['typeCloses']?.toString(),
      description: json['description']?.toString(),
      imageUrl: json['image_url']?.toString() ?? json['imageUrl']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'typeCloses': typeCloses,
    'description': description,
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