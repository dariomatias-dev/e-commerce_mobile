import 'package:flutter/material.dart';

class UserPreferencesInherited extends InheritedWidget {
  const UserPreferencesInherited({
    super.key,
    required this.favoriteProducts,
    required this.updateFavoriteProducts,
    required this.cartProducts,
    required this.updateCartProducts,
    required Widget child,
  }) : super(child: child);

  final List<String> favoriteProducts;
  final Function(List<String>) updateFavoriteProducts;

  final List<String> cartProducts;
  final Function(List<String>) updateCartProducts;

  static UserPreferencesInherited? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UserPreferencesInherited>();
  }

  @override
  bool updateShouldNotify(UserPreferencesInherited oldWidget) {
    return true;
  }
}
