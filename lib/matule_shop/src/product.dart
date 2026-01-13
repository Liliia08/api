class Product {
  final String id;
  final String title;
  final int price;
  final String description;
  final String typeClothes;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.typeClothes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      typeClothes: json['typeCloses'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'typeCloses': typeClothes,
    };
  }
}