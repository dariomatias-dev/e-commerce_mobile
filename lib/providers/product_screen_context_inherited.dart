import 'package:flutter/material.dart';

class ProductScreenInfoInherited extends InheritedWidget {
  const ProductScreenInfoInherited({
    super.key,
    required this.screenContext,
    required this.thereAreSimilarProducts,
    required this.chanceThereAreSimilarProducts,
    required Widget child,
  }) : super(child: child);

  final BuildContext screenContext;
  final bool thereAreSimilarProducts;
  final void Function(bool) chanceThereAreSimilarProducts;

  static ProductScreenInfoInherited? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProductScreenInfoInherited>();
  }

  @override
  bool updateShouldNotify(ProductScreenInfoInherited oldWidget) {
    return true;
  }
}
