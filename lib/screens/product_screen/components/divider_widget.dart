import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
      ),
    );
  }
}
