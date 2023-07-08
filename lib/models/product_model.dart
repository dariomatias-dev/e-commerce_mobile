class ProductModel {
  final String id;
  final String name;
  final String price;
  final String description;
  final List<String> imageUrlIds;
  final List<String> categoryIds;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrlIds,
    required this.categoryIds,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      price: map["price"] ?? "",
      description: map["description"] ?? "",
      imageUrlIds: (map["imageUrlIds"] as List<dynamic>).cast<String>(),
      categoryIds: (map["categoryIds"] as List<dynamic>).cast<String>(),
    );
  }
}
