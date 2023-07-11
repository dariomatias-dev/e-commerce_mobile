import 'package:flutter/material.dart';
import 'package:power_tech/utils/format_to_real.dart';

class PriceOptionsWidget extends StatefulWidget {
  const PriceOptionsWidget({
    super.key,
    required this.price,
    required this.productQuantity,
  });

  final String price;
  final int productQuantity;

  @override
  State<PriceOptionsWidget> createState() => _PriceOptionsWidgetState();
}

class _PriceOptionsWidgetState extends State<PriceOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    final double price = double.parse(widget.price) * widget.productQuantity;
    final String formattedPrice = formatToReal(price);

    final String valueInInstallments = (price / 12).toStringAsFixed(2);
    final String formattedValueInInstallments =
        formatToReal(double.parse(valueInInstallments));

    final double oldPrice = price * 1.1;
    final String formattedOldPrice = formatToReal(oldPrice);

    final double discountPrice = price * 0.85;
    final String formattedDisccountPrice = formatToReal(discountPrice);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400.withOpacity(0.2),
            spreadRadius: 12,
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "de $formattedOldPrice por:",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Text(
                      "No PIX com 15% de desconto",
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    formattedDisccountPrice,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            color: Colors.black54,
            height: 26,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "em 12x de $formattedValueInInstallments (sem juros) no cartão:",
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                formattedPrice,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
