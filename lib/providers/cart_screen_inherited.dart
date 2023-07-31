import 'package:flutter/material.dart';

import 'package:power_tech/models/price_and_quantity_model.dart';

class CartScreenInherited extends InheritedWidget {
  const CartScreenInherited({
    super.key,
    required this.totalPrice,
    required this.pricesAndQuantitiesMap,
    required this.updatePricesAndQuantitiesMap,
    required Widget child,
  }) : super(child: child);

  final String totalPrice;
  final Map<String, PriceAndQuantityModel> pricesAndQuantitiesMap;
  final Function(String, double, int) updatePricesAndQuantitiesMap;

  static CartScreenInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartScreenInherited>();
  }

  @override
  bool updateShouldNotify(CartScreenInherited oldWidget) {
    return oldWidget.totalPrice != totalPrice || oldWidget.pricesAndQuantitiesMap != pricesAndQuantitiesMap;
  }
}
