import 'package:flutter/material.dart';

class MyAppFavoritesInherited extends InheritedWidget {
  const MyAppFavoritesInherited({
    super.key,
    required this.favorites,
    required this.updateFavorites,
    required Widget child,
  }) : super(child: child);

  final List<String> favorites;
  final Function(List<String>) updateFavorites;

  static MyAppFavoritesInherited? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MyAppFavoritesInherited>();
  }

  @override
  bool updateShouldNotify(MyAppFavoritesInherited oldWidget) {
    return true;
  }
}
