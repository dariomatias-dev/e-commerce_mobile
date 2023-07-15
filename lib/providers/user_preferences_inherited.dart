import 'package:flutter/material.dart';

class UserPreferencesInherited extends InheritedWidget {
  const UserPreferencesInherited({
    super.key,
    required this.wishlistProductIds,
    required this.updateWishlistProductIds,
    required this.cartProductIds,
    required this.updateCartProductIds,
    required Widget child,
  }) : super(child: child);

  final List<String> wishlistProductIds;
  final Function(List<String>) updateWishlistProductIds;

  final List<String> cartProductIds;
  final Function(List<String>) updateCartProductIds;

  static UserPreferencesInherited? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UserPreferencesInherited>();
  }

  @override
  bool updateShouldNotify(UserPreferencesInherited oldWidget) {
    return true;
  }
}
