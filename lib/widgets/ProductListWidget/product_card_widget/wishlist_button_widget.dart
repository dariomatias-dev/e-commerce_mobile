import 'package:flutter/material.dart';

import 'package:power_tech/providers/main_screen_context_inherited.dart';
import 'package:power_tech/providers/my_app_favorites_inherited.dart';
import 'package:power_tech/providers/product_screen_context_inherited.dart';

import 'package:power_tech/utils/wishlist_manager/main.dart';

class WishlistButtonWidget extends StatelessWidget {
  const WishlistButtonWidget({super.key, required this.productId});

  final String productId;

  void updateWishlist(
    BuildContext screenContext,
    String productId,
    MyAppFavoritesInherited myAppFavoritesInherited,
  ) {
    final WishlistManager wishlistManager = WishlistManager(
      screenContext: screenContext,
      productId: productId,
      myAppFavoritesInherited: myAppFavoritesInherited,
    );
    wishlistManager.update();
  }

  @override
  Widget build(BuildContext context) {
    final BuildContext screenContext =
        MainScreenContextInherited.of(context)?.screenContext ??
            ProductScreenContextInherited.of(context)!.screenContext;
    final MyAppFavoritesInherited myAppFavoritesInherited =
        MyAppFavoritesInherited.of(context)!;

    return Positioned(
      right: 0,
      bottom: 4,
      child: InkWell(
        onTap: () => updateWishlist(
          screenContext,
          productId,
          myAppFavoritesInherited,
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
    );
  }
}
