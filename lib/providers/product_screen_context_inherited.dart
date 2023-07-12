import 'package:flutter/material.dart';

class ProductScreenContextInherited extends InheritedWidget {
  const ProductScreenContextInherited({
    super.key,
    required this.screenContext,
    required Widget child,
  }) : super(child: child);

  final BuildContext screenContext;

  static ProductScreenContextInherited? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProductScreenContextInherited>();
  }

  @override
  bool updateShouldNotify(ProductScreenContextInherited oldWidget) {
    return false;
  }
}
