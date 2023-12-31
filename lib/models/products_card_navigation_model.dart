import 'package:power_tech/models/product_card_model.dart';

class ProductsCardNavigationModel {
  ProductsCardNavigationModel({
    required this.skip,
    required this.take,
    required this.productsCard,
  });

  final int skip;
  final int take;
  final List<ProductCardModel> productsCard;

  factory ProductsCardNavigationModel.fromMap(Map<String, dynamic> map) {
    return ProductsCardNavigationModel(
      skip: map["skip"] ?? "",
      take: map["take"] ?? "",
      productsCard: (map["products"] as List).map((productCard) {
        return ProductCardModel.fromMap(productCard);
      }).toList(),
    );
  }
}
