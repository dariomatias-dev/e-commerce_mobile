import 'package:flutter/material.dart';
import 'package:power_tech/managers/user_preferences_manager.dart';

import 'package:power_tech/models/product_card_model.dart';
import 'package:power_tech/providers/cart_screen_inherited.dart';

import 'package:power_tech/screens/cart_screen/components/card_product_widget/custom_slidable_widget.dart';

class CartProductCardWidget extends StatefulWidget {
  const CartProductCardWidget({
    super.key,
    required this.productCard,
  });

  final ProductCardModel productCard;

  @override
  State<CartProductCardWidget> createState() => CartProductCardWidgetState();
}

class CartProductCardWidgetState extends State<CartProductCardWidget> {
  bool deleteProduct = false;

  void _updateDeleteProduct() {
    final UserPreferencesManager userPreferencesManager =
        UserPreferencesManager(
      listType: "cart",
      productId: widget.productCard.id,
      context: context,
    );
    userPreferencesManager.update();

    CartScreenInherited.of(context)?.removePriceAndQuantityMap(
      widget.productCard.id,
    );

    setState(() {
      deleteProduct = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      child: deleteProduct
          ? const SizedBox()
          : CustomSlidableWidget(
              productCard: widget.productCard,
              updateDeleteProduct: _updateDeleteProduct,
            ),
    );
  }
}
