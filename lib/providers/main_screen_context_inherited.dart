import 'package:flutter/material.dart';

class MainScreenContextInherited extends InheritedWidget {
  const MainScreenContextInherited({
    super.key,
    required this.screenContext,
    required Widget child,
  }) : super(child: child);

  final BuildContext screenContext;

  static MainScreenContextInherited? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MainScreenContextInherited>();
  }

  @override
  bool updateShouldNotify(MainScreenContextInherited oldWidget) {
    return false;
  }
}
