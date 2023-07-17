import 'package:flutter/material.dart';

import 'package:power_tech/screens/product_screen/components/bottomnavigationbar_product_widget/cart_button_widget.dart';

class BottomNavigationBarProductWidget extends StatelessWidget {
  const BottomNavigationBarProductWidget({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 24),
      child: Row(
        children: [
          CartButtonWidget(
            productId: productId,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_bag,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      ("Comprar").toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
