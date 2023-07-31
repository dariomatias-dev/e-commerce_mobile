import 'package:flutter/material.dart';

class CartScreenInherited extends InheritedWidget {
  const CartScreenInherited({
    super.key,
    required this.totalPrice,
    required this.updatePricesAndQuantitiesMap,
    required Widget child,
  }) : super(child: child);

  final String totalPrice;
  final Function(String, double, int) updatePricesAndQuantitiesMap;

  static CartScreenInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartScreenInherited>();
  }

  @override
  bool updateShouldNotify(CartScreenInherited oldWidget) {
    return oldWidget.child != child;
  }
}
