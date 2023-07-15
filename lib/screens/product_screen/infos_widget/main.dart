import 'package:flutter/material.dart';

import 'package:power_tech/screens/product_screen/infos_widget/product_details_widget.dart';
import 'package:power_tech/screens/product_screen/infos_widget/similar_products_widget.dart';

class InfosWidget extends StatelessWidget {
  const InfosWidget({
    super.key,
    required this.productId,
    required this.name,
    required this.price,
    required this.description,
    required this.categoryIds,
  });

  final String productId;
  final String name;
  final String price;
  final String description;
  final List<String> categoryIds;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400.withOpacity(0.35),
            spreadRadius: 10,
            blurRadius: 20,
            offset: const Offset(10, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          ProductDetailsWidget(
            name: name,
            description: description,
            price: price,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
          ),
          SimilarProductsWidget(
            productId: productId,
            categoryIds: categoryIds,
          ),
        ],
      ),
    );
  }
}
