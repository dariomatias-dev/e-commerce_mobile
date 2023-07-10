import 'package:flutter/material.dart';

class ProductQuantityPickerWidget extends StatefulWidget {
  const ProductQuantityPickerWidget({
    super.key,
    required this.productQuantity,
    required this.increaseAmountProduct,
    required this.decreaseAmountProduct,
  });

  final int productQuantity;
  final VoidCallback increaseAmountProduct;
  final VoidCallback decreaseAmountProduct;

  @override
  State<ProductQuantityPickerWidget> createState() =>
      _ProductQuantityPickerWidgetState();
}

class _ProductQuantityPickerWidgetState
    extends State<ProductQuantityPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            child: Text(
              "Escolha a quantidadede de produtos:",
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              ButtonWidget(
                icon: Icons.remove,
                function: widget.decreaseAmountProduct,
              ),
              const SizedBox(width: 8),
              Text(
                "${widget.productQuantity}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              ButtonWidget(
                icon: Icons.add,
                function: widget.increaseAmountProduct,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.icon,
    required this.function,
  });

  final IconData icon;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 18,
        ),
      ),
    );
  }
}
