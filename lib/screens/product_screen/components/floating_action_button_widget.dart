import 'package:flutter/material.dart';

import 'package:power_tech/managers/user_preferences_manager.dart';

import 'package:power_tech/providers/product_screen_context_inherited.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
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
        ProductScreenInfoInherited.of(context)!.screenContext;

    return FloatingActionButton(
      onPressed: () => updateUserPreferences(
        productId,
        context,
        screenContext,
      ),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Tooltip(
        message: "Carrinho",
        child: Icon(
          Icons.shopping_cart,
        ),
      ),
    );
  }
}
