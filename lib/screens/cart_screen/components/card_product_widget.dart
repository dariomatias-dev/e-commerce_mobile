import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:power_tech/widgets/product_quantity_picker_widget.dart';

class CartProductCardWidget extends StatefulWidget {
  const CartProductCardWidget({super.key});

  @override
  State<CartProductCardWidget> createState() => CartProductCardWidgetState();
}

class CartProductCardWidgetState extends State<CartProductCardWidget> {
  int productQuantity = 0;

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
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 22,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 70,
            ),
            child: Image.network(
              "${dotenv.env["IMAGE_URL"]}/52974159533_a614b9cd45_w.jpg",
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Processador Intel Core i7-10700K",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "R\$ 2.166,66",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ProductQuantityPickerWidget(
                        productQuantity: productQuantity,
                        increaseAmountProduct: increaseAmountProduct,
                        decreaseAmountProduct: increaseAmountProduct,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
