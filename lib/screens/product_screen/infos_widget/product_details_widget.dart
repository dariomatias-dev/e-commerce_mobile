import 'package:flutter/material.dart';

import 'package:power_tech/screens/product_screen/infos_widget/payment_calculator_widget.dart';
import 'package:power_tech/screens/product_screen/infos_widget/product_quantity_picker_widget.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({
    super.key,
    required this.name,
    required this.description,
    required this.price,
  });

  final String name;
  final String description;
  final String price;

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  int productQuantity = 1;

  void increaseAmountProduct() {
    if (productQuantity < 20) {
      setState(() {
        productQuantity++;
      });
    }
  }

  void decreaseAmountProduct() {
    if (productQuantity > 1) {
      setState(() {
        productQuantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ProductQuantityPickerWidget(
                    productQuantity: productQuantity,
                    increaseAmountProduct: increaseAmountProduct,
                    decreaseAmountProduct: decreaseAmountProduct,
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
        Container(
          width: MediaQuery.of(context).size.width,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
          ),
        ),
        PriceOptionsWidget(
          price: widget.price,
          productQuantity: productQuantity,
        ),
      ],
    );
  }
}