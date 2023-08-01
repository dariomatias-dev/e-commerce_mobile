import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:power_tech/models/price_and_quantity_model.dart';
import 'package:power_tech/models/product_card_model.dart';

import 'package:power_tech/providers/user_preferences_inherited.dart';

import 'package:power_tech/services/api_services.dart';

class PricesAndQuantitiesMapManager {
  PricesAndQuantitiesMapManager({
    required this.pricesAndQuantitiesMap,
    this.setTotalOrderPrice,
    required this.context,
  });
  final VoidCallback? setTotalOrderPrice;
  final BuildContext context;

  final APIServices apiServices = APIServices();
  final Map<String, PriceAndQuantityModel> pricesAndQuantitiesMap;

  // Adds the new product to the cart in the variable pricesAndQuantitiesMap
  void addPriceAndQuantityMap(List<ProductCardModel> productCards) {
    for (ProductCardModel productCard in productCards) {
      if (!pricesAndQuantitiesMap.containsKey(productCard.id)) {
        pricesAndQuantitiesMap[productCard.id] = PriceAndQuantityModel(
          price: productCard.price,
          quantity: 1,
        );
      }
    }
  }

  // If the quantity is one, the product is withdrawn, otherwise it is added or updated
  void updatePricesAndQuantitiesMap(
    String productId,
    double price,
    int quantity,
  ) {
    if (quantity == 1) {
      pricesAndQuantitiesMap.remove(productId);
    }

    pricesAndQuantitiesMap[productId] = PriceAndQuantityModel(
      price: price,
      quantity: quantity,
    );

    setTotalOrderPrice!();
  }

  // Removes the product that is no longer in the cart from the pricesAndQuantitiesMapManager variable
  void removePriceAndQuantityMap() {
    final List<String> cartProductIds =
        UserPreferencesInherited.of(context)!.cartProductIds;
    final List<String> mapKeys = pricesAndQuantitiesMap.keys.toList();

    for (String key in mapKeys) {
      if (!cartProductIds.contains(key)) {
        pricesAndQuantitiesMap.remove(key);
      }
    }
  }

  // Remove product from variable pricesAndQuantitiesMap by ID
  void removePriceAndQuantityMapById(String productId) {
    pricesAndQuantitiesMap.remove(productId);

    setTotalOrderPrice!();
  }

  // Remove all products from cart
  Future<void> removeAllProducts() async {
    final UserPreferencesInherited userPreferencesInherited =
        UserPreferencesInherited.of(context)!;

    userPreferencesInherited.updateCartProductIds([]);

    final Map<String, dynamic> body = {
      "productIds": [],
    };

    try {
      await apiServices.put(
        "cart/57e99e52-753e-4da7-8a67-a6286edd2ee4",
        body,
      );
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }
}
