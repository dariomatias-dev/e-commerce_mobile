import 'package:flutter/material.dart';

import 'package:power_tech/providers/main_screen_context_inherited.dart';
import 'package:power_tech/providers/product_screen_context_inherited.dart';

import 'package:power_tech/managers/user_preferences_manager.dart';

class WishlistButtonWidget extends StatelessWidget {
  const WishlistButtonWidget({super.key, required this.productId});

  final String productId;

  void updateUserPreferences(
    String productId,
    BuildContext context,
    BuildContext screenContext,
  ) {
    final UserPreferencesManager userPreferencesManager = UserPreferencesManager(
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
            ProductScreenContextInherited.of(context)!.screenContext;

    return Positioned(
      right: 0,
      bottom: 4,
      child: InkWell(
        onTap: () => updateUserPreferences(
          productId,
          context,
          screenContext,
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
