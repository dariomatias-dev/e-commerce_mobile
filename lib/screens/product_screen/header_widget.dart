import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.screenContext});

  final BuildContext screenContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        right: 12,
        bottom: 10,
        left: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Tooltip(
            message: "Sair",
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: Colors.grey.shade400.withOpacity(0.9),
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 20,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
          const Text(
            "Detalhes",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: const Tooltip(
                message: "Favorito",
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white54,
                  size: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
