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