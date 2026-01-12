class Product {
  final String id;
  final String title;
  final String price;  // Оставляем String для отображения
  final String? typeCloses;

  Product({
    required this.id,
    required this.title,
    required this.price,  // String!
    this.typeCloses,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Без названия',
      price: (json['price'] ?? 0).toString(),  // Преобразуем в String
      typeCloses: json['typeCloses']?.toString(),
    );
  }
}

class News {
  final String id;
  final String title;
  final String? imageUrl;

  News({
    required this.id,
    required this.title,
    this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Новость',
      imageUrl: json['image_url']?.toString(),
    );
  }
}