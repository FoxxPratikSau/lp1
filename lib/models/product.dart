class Product {
  final int id;
  final String? title;
  final String? thumbnail;
  final double price;
  final double discountPercentage;
  final String? description;

  Product({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.discountPercentage,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] as String?,
      thumbnail: json['thumbnail'] as String?,
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      description: json['description'] as String?,
    );
  }
}
