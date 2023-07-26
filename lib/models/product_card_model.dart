class ProductCardModel {
  final String id;
  final String name;
  final String price;

  ProductCardModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory ProductCardModel.fromMap(Map<String, dynamic> map) {
    return ProductCardModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      price: map["price"] ?? "",
    );
  }
}
