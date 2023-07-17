import 'package:flutter/material.dart';

import 'package:power_tech/managers/user_preferences_manager.dart';

import 'package:power_tech/providers/product_screen_context_inherited.dart';

class CartButtonWidget extends StatelessWidget {
  const CartButtonWidget({
    super.key,
    required this.productId,
  });

  final String productId;

  void updateUserPreferences(
    String productId,
    BuildContext context,
    BuildContext screenContext,
  ) {
    final UserPreferencesManager userPreferencesManager =
        UserPreferencesManager(
      listType: "cart",
      productId: productId,
      screenContext: screenContext,
      context: context,
    );
    userPreferencesManager.update();
  }

  @override
  Widget build(BuildContext context) {
    final BuildContext screenContext =
        ProductScreenContextInherited.of(context)!.screenContext;

    return InkWell(
      onTap: () => updateUserPreferences(
        productId,
        context,
        screenContext,
      ),
      child: Tooltip(
        message: "Carrinho",
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
