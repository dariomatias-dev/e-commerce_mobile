class ProductCardModel {
  ProductCardModel({
    required this.id,
    required this.name,
    required this.price,
  });

  final String id;
  final String name;
  final double price;

  factory ProductCardModel.fromMap(Map<String, dynamic> map) {
    return ProductCardModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      price: double.parse(map["price"]),
    );
  }
}
