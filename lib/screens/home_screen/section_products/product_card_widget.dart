import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import 'package:power_tech/models/product_card_model.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key, required this.productCard});

  final ProductCard productCard;

  @override
  Widget build(BuildContext context) {
    NumberFormat realFormat =
        NumberFormat.currency(locale: "pt_BR", symbol: "R\$");

    double price = double.parse(productCard.price);

    String formattedPrice = realFormat.format(price);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 90,
                          maxHeight: 120,
                        ),
                        child: Image.network(
                          "${dotenv.env["IMAGE_URL"]}/${productCard.imageUrlId}.jpg",
                          width: 100,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 4,
                  child: InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite_outline,
                        color: Colors.white54,
                        size: 20,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
            Text(
              productCard.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              formattedPrice,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Comprar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
