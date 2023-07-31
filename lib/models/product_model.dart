class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.amountOfImages,
    required this.categoryIds,
  });

  final String id;
  final String name;
  final double price;
  final String description;
  final int amountOfImages;
  final List<String> categoryIds;

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      price: double.parse(map["price"]),
      description: map["description"] ?? "",
      amountOfImages: map["amountOfImages"] ?? 0,
      categoryIds: (map["categoryIds"] as List<dynamic>).cast<String>(),
    );
  }
}
