import 'package:flutter/material.dart';
import 'package:power_tech/providers/product_screen_context_inherited.dart';

import 'package:power_tech/widgets/divider_widget.dart';
import 'package:power_tech/screens/product_screen/components/infos_widget/product_details_widget.dart';
import 'package:power_tech/screens/product_screen/components/infos_widget/similar_products_widget.dart';

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
  final double price;
  final String description;
  final List<String> categoryIds;

  @override
  Widget build(BuildContext context) {
    final bool thereAreSimilarProducts =
        ProductScreenInfoInherited.of(context)!.thereAreSimilarProducts;

    return Container(
      padding: const EdgeInsets.only(
        top: 20,
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
      child: thereAreSimilarProducts
          ? Column(
              children: [
                ProductDetailsWidget(
                  name: name,
                  description: description,
                  price: price,
                ),
                const DividerWidget(),
                SimilarProductsWidget(
                  productId: productId,
                  categoryIds: categoryIds,
                ),
              ],
            )
          : ProductDetailsWidget(
              name: name,
              description: description,
              price: price,
            ),
    );
  }
}
