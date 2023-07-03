import 'package:power_tech/models/product_card_model.dart';

class ProductsCardNavigation {
  final int skip;
  final int take;
  final List<ProductCard> productsCard;

  ProductsCardNavigation({
    required this.skip,
    required this.take,
    required this.productsCard,
  });

  factory ProductsCardNavigation.fromMap(Map<String, dynamic> map) {
    return ProductsCardNavigation(
      skip: map["skip"] ?? "",
      take: map["take"] ?? "",
      productsCard: (map["products"] as List).map((productCard) {
        return ProductCard.fromMap(productCard);
      }).toList(),
    );
  }
}
