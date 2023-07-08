class ProductCardModel {
  final String id;
  final String name;
  final String imageUrlId;
  final String price;

  ProductCardModel({
    required this.id,
    required this.name,
    required this.imageUrlId,
    required this.price,
  });

  factory ProductCardModel.fromMap(Map<String, dynamic> map) {
    return ProductCardModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      imageUrlId: map["imageUrlId"] ?? "",
      price: map["price"] ?? "",
    );
  }
}
