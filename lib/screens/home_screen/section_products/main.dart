import 'package:flutter/material.dart';

import 'package:power_tech/screens/home_screen/section_products/filter_selector_widget.dart';

import 'package:power_tech/widgets/ProductListWidget/main.dart';

class SectionProducts extends StatefulWidget {
  const SectionProducts({super.key});

  @override
  State<SectionProducts> createState() => _SectionProductsState();
}

class _SectionProductsState extends State<SectionProducts> {
  @override
  Widget build(BuildContext context) {
    const String routeName = "products";

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Produtos",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FilterSelectorWidget(),
            ],
          ),
        ),
        const SizedBox(height: 2),
        const ProductListWidget(
          routeName: routeName,
        ),
      ],
    );
  }
}
