import 'package:flutter/material.dart';

import 'package:power_tech/utils/format_to_real.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    super.key,
    required this.name,
    required this.price,
    required this.description,
  });

  final String name;
  final String price;
  final String description;

  @override
  Widget build(BuildContext context) {
    final String formattedPrice = formatToReal(price);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 16,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  name,
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                formattedPrice,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
