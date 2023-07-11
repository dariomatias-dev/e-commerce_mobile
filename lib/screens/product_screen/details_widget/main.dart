import 'package:flutter/material.dart';
import 'package:power_tech/screens/product_screen/details_widget/payment_calculator_widget/main.dart';
import 'package:power_tech/screens/product_screen/details_widget/similar_products_widget.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
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
          Padding(
            padding: const EdgeInsets.only(
              right: 12,
              bottom: 16,
              left: 12,
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
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
          ),
          PaymentCalculatorWidget(
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
