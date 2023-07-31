import 'package:flutter/material.dart';
import 'package:power_tech/models/price_and_quantity_model.dart';

import 'package:power_tech/models/product_card_model.dart';

import 'package:power_tech/providers/cart_screen_inherited.dart';

import 'package:power_tech/widgets/product_quantity_picker_widget.dart';

import 'package:power_tech/utils/format_to_real.dart';

class PriceQuantitySelectorWidget extends StatefulWidget {
  const PriceQuantitySelectorWidget({
    super.key,
    required this.productCard,
  });

  final ProductCardModel productCard;

  @override
  State<PriceQuantitySelectorWidget> createState() =>
      _PriceQuantitySelectorWidgetState();
}

class _PriceQuantitySelectorWidgetState
    extends State<PriceQuantitySelectorWidget> {
  late int productQuantity;
  Map<String, PriceAndQuantityModel>? previousPricesAndQuantitiesMap;

  void updateProductPrice(int newQuantity) {
    CartScreenInherited.of(context)?.updatePricesAndQuantitiesMap(
      widget.productCard.id,
      widget.productCard.price,
      newQuantity,
    );

    setState(() {
      productQuantity = newQuantity;
    });
  }

  void _setProductQuantity() {
    final Map<String, PriceAndQuantityModel> pricesAndQuantitiesMap =
        CartScreenInherited.of(context)!.pricesAndQuantitiesMap;
    productQuantity =
        pricesAndQuantitiesMap[widget.productCard.id]?.quantity ?? 1;

    previousPricesAndQuantitiesMap = pricesAndQuantitiesMap;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setProductQuantity();
  }

  @override
  void didUpdateWidget(PriceQuantitySelectorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (CartScreenInherited.of(context)!.pricesAndQuantitiesMap !=
        previousPricesAndQuantitiesMap) {
      _setProductQuantity();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double totalProductPrice = widget.productCard.price * productQuantity;
    final String formattedPrice = formatToReal(totalProductPrice);

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
          updateProductPrice: updateProductPrice,
        ),
      ],
    );
  }
}
