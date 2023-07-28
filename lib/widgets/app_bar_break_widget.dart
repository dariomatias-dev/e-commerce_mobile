import 'package:flutter/material.dart';

class AppBarBreakWidget extends StatelessWidget {
  const AppBarBreakWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 3,
        width: 70,
        margin: const EdgeInsets.only(
          top: 10,
          bottom: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
