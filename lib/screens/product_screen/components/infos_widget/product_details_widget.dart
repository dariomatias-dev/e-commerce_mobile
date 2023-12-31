import 'package:flutter/material.dart';

import 'package:power_tech/widgets/divider_widget.dart';
import 'package:power_tech/widgets/price_options_widget.dart';
import 'package:power_tech/widgets/product_quantity_picker_widget.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({
    super.key,
    required this.name,
    required this.description,
    required this.price,
  });

  final String name;
  final String description;
  final double price;

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  int productQuantity = 1;

  void updateProductPrice(int newQuantity) {
    setState(() {
      productQuantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice = widget.price * productQuantity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 12,
            bottom: 16,
            left: 12,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.name,
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ProductQuantityPickerWidget(
                    productQuantity: productQuantity,
                    updateProductPrice: updateProductPrice,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const DividerWidget(),
        PriceOptionsWidget(
          price: totalPrice,
        ),
      ],
    );
  }
}
