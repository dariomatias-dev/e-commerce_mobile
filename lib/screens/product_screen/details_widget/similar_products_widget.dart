import 'package:flutter/material.dart';
import 'package:power_tech/widgets/ProductListWidget/main.dart';

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
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Produtos similares",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          ProductListWidget(
            routeName: routeName,
            productId: widget.productId,
            categoryIds: widget.categoryIds.join(","),
          ),
        ],
      ),
    );
  }
}
