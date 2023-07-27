import 'package:flutter/material.dart';

import 'package:power_tech/managers/user_preferences_manager.dart';

import 'package:power_tech/providers/product_screen_context_inherited.dart';

class FloatingActionWidget extends StatelessWidget {
  const FloatingActionWidget({
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
      child: const Tooltip(
        message: "Carrinho",
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
