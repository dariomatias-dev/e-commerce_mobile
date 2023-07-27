import 'package:flutter/material.dart';

import 'package:power_tech/providers/main_screen_context_inherited.dart';
import 'package:power_tech/providers/product_screen_context_inherited.dart';
import 'package:power_tech/providers/user_preferences_inherited.dart';

import 'package:power_tech/managers/user_preferences_manager.dart';

class WishlistButtonWidget extends StatelessWidget {
  const WishlistButtonWidget({
    super.key,
    required this.productId,
    required this.padding,
    required this.containerDecoration,
  });

  final String productId;
  final double padding;
  final BoxDecoration containerDecoration;

  void updateUserPreferences(
    String productId,
    BuildContext context,
    BuildContext screenContext,
  ) {
    final UserPreferencesManager userPreferencesManager =
        UserPreferencesManager(
      listType: "wishlist",
      productId: productId,
      screenContext: screenContext,
      context: context,
    );
    userPreferencesManager.update();
  }

  @override
  Widget build(BuildContext context) {
    final BuildContext screenContext =
        MainScreenContextInherited.of(context)?.screenContext ??
            ProductScreenInfoInherited.of(context)!.screenContext;
    final List<String> productIds =
        UserPreferencesInherited.of(context)?.wishlistProductIds ?? [];

    return InkWell(
      onTap: () => updateUserPreferences(
        productId,
        context,
        screenContext,
      ),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: containerDecoration,
        child: Tooltip(
          message: "Favorito",
          child: Icon(
            productIds.contains(productId)
                ? Icons.favorite_outlined
                : Icons.favorite_outline,
            color: productIds.contains(productId)
                ? Colors.white.withOpacity(0.9)
                : Colors.white60,
            size: 20,
          ),
        ),
      ),
    );
  }
}
