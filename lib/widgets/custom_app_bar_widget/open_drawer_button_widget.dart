import 'package:flutter/material.dart';

class OpenDrawerButtonWidget extends StatelessWidget {
  const OpenDrawerButtonWidget({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        scaffoldKey.currentState?.openDrawer();
      },
      child: Tooltip(
        message: "Abrir menu",
        child: FractionallySizedBox(
          widthFactor: 0.35,
          heightFactor: 0.35,
          child: Image.asset(
            "assets/icons/menu_icon.png",
            width: 4,
          ),
        ),
      ),
    );
  }
}
