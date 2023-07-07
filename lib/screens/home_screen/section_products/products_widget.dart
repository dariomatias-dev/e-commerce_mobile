import 'package:flutter/material.dart';

import 'package:power_tech/models/product_card_model.dart';

import 'package:power_tech/screens/home_screen/section_products/product_card_widget.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key, required this.productsCard});

  final List<ProductCard> productsCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productsCard.length * 2 + 1,
        itemBuilder: (context, index) {
          if (index == 0 || index == productsCard.length + 1) {
            return const SizedBox(width: 6);
          } else if (index % 2 == 0) {
            return const SizedBox(width: 10);
          }

          return ProductCardWidget(
            productCard: productsCard[(index/ 2).floor()],
          );
        },
      ),
    );
  }
}
