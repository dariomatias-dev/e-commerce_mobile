import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:power_tech/screens/cart_screen/components/card_product_widget/product_card_item_widget.dart';

class CustomSlidableWidget extends StatelessWidget {
  const CustomSlidableWidget({
    super.key,
    required this.updateDeleteProduct,
  });

  final VoidCallback updateDeleteProduct;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.15,
        motion: const ScrollMotion(),
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: updateDeleteProduct,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      child: const ProductCardItemWidget(),
    );
  }
}
