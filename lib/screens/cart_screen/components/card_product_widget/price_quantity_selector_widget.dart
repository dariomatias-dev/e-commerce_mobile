import 'package:flutter/material.dart';
import 'package:power_tech/utils/format_to_real.dart';

import 'package:power_tech/widgets/product_quantity_picker_widget.dart';

class PriceQuantitySelectorWidget extends StatefulWidget {
  const PriceQuantitySelectorWidget({super.key});

  @override
  State<PriceQuantitySelectorWidget> createState() =>
      _PriceQuantitySelectorWidgetState();
}

class _PriceQuantitySelectorWidgetState
    extends State<PriceQuantitySelectorWidget> {
  int productQuantity = 1;

  void increaseAmountProduct() {
    if (productQuantity < 20) {
      setState(() {
        productQuantity++;
      });
    }
  }

  void decreaseAmountProduct() {
    if (productQuantity > 1) {
      setState(() {
        productQuantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double productPrice = 2166.66;
    final price = productPrice * productQuantity;
    final String formattedPrice = formatToReal(price);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          formattedPrice,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        ProductQuantityPickerWidget(
          productQuantity: productQuantity,
          increaseAmountProduct: increaseAmountProduct,
          decreaseAmountProduct: decreaseAmountProduct,
        ),
      ],
    );
  }
}
