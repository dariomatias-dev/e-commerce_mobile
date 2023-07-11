import 'package:flutter/material.dart';

class SimilarProductsWidget extends StatefulWidget {
  const SimilarProductsWidget({super.key, required this.categoryIds});

  final List<String> categoryIds;

  @override
  State<SimilarProductsWidget> createState() => _SimilarProductsWidgetState();
}

class _SimilarProductsWidgetState extends State<SimilarProductsWidget> {
  @override
  Widget build(BuildContext context) {
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
      child: const Text("oi"),
    );
  }
}
