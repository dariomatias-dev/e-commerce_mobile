import 'package:flutter/material.dart';
import 'package:power_tech/widgets/vertical_list_products_widget/main.dart';

class SimilarProductsWidget extends StatefulWidget {
  const SimilarProductsWidget({
    super.key,
    required this.productId,
    required this.categoryIds,
  });

  final List<String> categoryIds;
  final String productId;

  @override
  State<SimilarProductsWidget> createState() => _SimilarProductsWidgetState();
}

class _SimilarProductsWidgetState extends State<SimilarProductsWidget> {
  @override
  Widget build(BuildContext context) {
    const String routeName = "products-by-category-ids";

    return Container(
      padding: const EdgeInsets.only(
        top: 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Text(
              "Produtos similares",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 4),
          VerticalListProductsWidget(
            routeName: routeName,
            productId: widget.productId,
            categoryIds: widget.categoryIds.join(","),
          ),
        ],
      ),
    );
  }
}
