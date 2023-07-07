import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Tooltip(
          message: "Sair",
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Ink(
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text("Hello"),
      ),
    );
  }
}
