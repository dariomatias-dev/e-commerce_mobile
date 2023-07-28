import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:power_tech/models/product_card_model.dart';

import 'package:power_tech/screens/product_screen/main.dart';

import 'package:power_tech/widgets/wishlist_button_widget.dart';

import 'package:power_tech/utils/format_string.dart';
import 'package:power_tech/utils/format_to_real.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.productCard,
  });

  final ProductCardModel productCard;

  @override
  Widget build(BuildContext context) {
    final double price = double.parse(productCard.price);
    final String formattedPrice = formatToReal(price);
    final String productName = productCard.name;
    final String formattedProductName = formatString(productName);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        width: 140,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductScreen(
                        productId: productCard.id,
                      );
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                height: 90,
                child: Center(
                  child: Image.network(
                    "${dotenv.env["PRODUCT_IMAGES_BASE_URL"]}/$formattedProductName/${formattedProductName}_1.png",
                    width: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: Text(
                      productName,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formattedPrice,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      WishlistButtonWidget(
                        productId: productCard.id,
                        padding: 10,
                        containerDecoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
