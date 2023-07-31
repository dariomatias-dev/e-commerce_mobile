import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:power_tech/models/product_card_model.dart';

import 'package:power_tech/screens/cart_screen/components/card_product_widget/price_quantity_selector_widget.dart';
import 'package:power_tech/utils/format_string.dart';

class ProductCardItemWidget extends StatefulWidget {
  const ProductCardItemWidget({
    super.key,
    required this.productCard,
  });

  final ProductCardModel productCard;

  @override
  State<ProductCardItemWidget> createState() => _ProductCardItemWidgetState();
}

class _ProductCardItemWidgetState extends State<ProductCardItemWidget> {
  @override
  Widget build(BuildContext context) {
    final String formattedProductName = formatString(widget.productCard.name);

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 70,
            ),
            child: Image.network(
              "${dotenv.env["PRODUCT_IMAGES_BASE_URL"]}/$formattedProductName/${formattedProductName}_1.png",
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productCard.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  PriceQuantitySelectorWidget(
                    productCard: widget.productCard,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
