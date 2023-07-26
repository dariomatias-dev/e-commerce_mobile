class ProductModel {
  final String id;
  final String name;
  final String price;
  final String description;
  final int amountOfImages;
  final List<String> categoryIds;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.amountOfImages,
    required this.categoryIds,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      price: map["price"] ?? "",
      description: map["description"] ?? "",
      amountOfImages: map["amountOfImages"] ?? 0,
      categoryIds: (map["categoryIds"] as List<dynamic>).cast<String>(),
    );
  }
}
