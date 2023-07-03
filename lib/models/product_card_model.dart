class ProductCard {
  final String id;
  final String name;
  final String imageUrlId;
  final String price;

  ProductCard({
    required this.id,
    required this.name,
    required this.imageUrlId,
    required this.price,
  });

  factory ProductCard.fromMap(Map<String, dynamic> map) {
    return ProductCard(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      imageUrlId: map["imageUrlId"] ?? "",
      price: map["price"] ?? "",
    );
  }
}
