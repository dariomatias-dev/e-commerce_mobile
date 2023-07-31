import 'package:flutter/material.dart';
import 'package:power_tech/providers/cart_screen_inherited.dart';
import 'package:power_tech/widgets/price_options_widget.dart';

class SectionPriceOptionsWidget extends StatelessWidget {
  const SectionPriceOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double totalOrderPrice =
        CartScreenInherited.of(context)!.totalOrderPrice;

    return Column(
      children: [
        PriceOptionsWidget(
          price: totalOrderPrice,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
