import 'package:flutter/material.dart';

import 'package:power_tech/models/price_and_quantity_model.dart';

class CartScreenInherited extends InheritedWidget {
  const CartScreenInherited({
    super.key,
    required this.totalOrderPrice,
    required this.pricesAndQuantitiesMap,
    required this.updatePricesAndQuantitiesMap,
    required this.removePriceAndQuantityMap,
    required Widget child,
  }) : super(child: child);

  final double totalOrderPrice;
  final Map<String, PriceAndQuantityModel> pricesAndQuantitiesMap;
  final Function(String, double, int) updatePricesAndQuantitiesMap;
  final Function(String) removePriceAndQuantityMap;

  static CartScreenInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartScreenInherited>();
  }

  @override
  bool updateShouldNotify(CartScreenInherited oldWidget) {
    return oldWidget.totalOrderPrice != totalOrderPrice || oldWidget.pricesAndQuantitiesMap != pricesAndQuantitiesMap;
  }
}
