import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:power_tech/models/product_card_model.dart';

import 'package:power_tech/providers/main_screen_context_inherited.dart';
import 'package:power_tech/providers/my_app_favorites_inherited.dart';
import 'package:power_tech/providers/product_screen_context_inherited.dart';

import 'package:power_tech/screens/product_screen/main.dart';

import 'package:power_tech/utils/format_to_real.dart';
import 'package:power_tech/utils/wishlist_manager/main.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key, required this.productCard});

  final ProductCardModel productCard;

  void updateWishlist(
    BuildContext screenContext,
    String productId,
    List<String> favorites,
  ) {
    final WishlistManager wishlistManager = WishlistManager(
      screenContext: screenContext,
      productId: productId,
      favorites: favorites,
    );
    wishlistManager.update();
  }

  @override
  Widget build(BuildContext context) {
    final BuildContext screenContext =
        MainScreenContextInherited.of(context)?.screenContext ??
            ProductScreenContextInherited.of(context)!.screenContext;
    final List<String> favorites =
        MyAppFavoritesInherited.of(context)!.favorites;

    final double price = double.parse(productCard.price);
    final String formattedPrice = formatToReal(price);

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: GestureDetector(
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
                    onTap: () => updateWishlist(
                      screenContext,
                      productCard.id,
                      favorites,
                    ),
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
                      child: const Tooltip(
                        message: "Favorito",
                        child: Icon(
                          Icons.favorite_outline,
                          color: Colors.white54,
                          size: 20,
                        ),
                      ),
                    ),
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
