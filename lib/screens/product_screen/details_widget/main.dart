import 'package:flutter/material.dart';
import 'package:power_tech/screens/product_screen/details_widget/payment_calculator_widget/main.dart';
import 'package:power_tech/screens/product_screen/details_widget/similar_products_widget.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    super.key,
    required this.name,
    required this.price,
    required this.description,
    required this.categoryIds,
  });

  final String name;
  final String price;
  final String description;
  final List<String> categoryIds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const Divider(
            color: Colors.black54,
            height: 40,
          ),
          PaymentCalculatorWidget(
            price: price,
          ),
          const Divider(
            color: Colors.black54,
            height: 40,
          ),
          SimilarProductsWidget(
            categoryIds: categoryIds,
          ),
        ],
      ),
    );
  }
}
