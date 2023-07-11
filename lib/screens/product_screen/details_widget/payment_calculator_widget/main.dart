import 'package:flutter/material.dart';
import 'package:power_tech/screens/product_screen/details_widget/payment_calculator_widget/price_options_widget.dart';
import 'package:power_tech/screens/product_screen/details_widget/payment_calculator_widget/product_quantity_picker_widget.dart';

class PaymentCalculatorWidget extends StatefulWidget {
  const PaymentCalculatorWidget({super.key, required this.price});
  final String price;

  @override
  State<PaymentCalculatorWidget> createState() =>
      _PaymentCalculatorWidgetState();
}

class _PaymentCalculatorWidgetState extends State<PaymentCalculatorWidget> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12,
      ),
      child: Column(
        children: [
          ProductQuantityPickerWidget(
            productQuantity: productQuantity,
            increaseAmountProduct: increaseAmountProduct,
            decreaseAmountProduct: decreaseAmountProduct,
          ),
          const SizedBox(height: 16),
          PriceOptionsWidget(
            price: widget.price,
            productQuantity: productQuantity,
          ),
        ],
      ),
    );
  }
}
