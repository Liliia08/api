class News {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;

  News({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['image'],
    );
  }
}