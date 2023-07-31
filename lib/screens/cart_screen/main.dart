import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'dart:convert';

import 'package:power_tech/models/price_and_quantity_model.dart';
import 'package:power_tech/models/product_card_model.dart';

import 'package:power_tech/providers/cart_screen_inherited.dart';
import 'package:power_tech/providers/user_preferences_inherited.dart';

import 'package:power_tech/screens/cart_screen/components/card_product_widget/main.dart';
import 'package:power_tech/screens/cart_screen/components/section_price_options_widget.dart';
import 'package:power_tech/screens/main_screen/components/drawer_widget/main.dart';

import 'package:power_tech/widgets/app_bar_break_widget.dart';
import 'package:power_tech/widgets/custom_app_bar_widget/main.dart';
import 'package:power_tech/widgets/feedback_widget.dart';

import 'package:power_tech/services/api_services.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final APIServices apiServices = APIServices();
  ValueNotifier<List<ProductCardModel>?> productCards =
      ValueNotifier<List<ProductCardModel>?>(null);

  List<String>? previousCartProductIds;
  Map<String, PriceAndQuantityModel> pricesAndQuantitiesMap = {};
  late double totalOrderPrice;

  Future<void> fetchData() async {
    final List<String>? cartProductIds =
        UserPreferencesInherited.of(context)?.cartProductIds;

    if (cartProductIds != null && cartProductIds.isNotEmpty) {
      final String url =
          "products-by-ids?productIds=${cartProductIds.join(",")}&returnAllProducts=true&skip=0";

      var response = await apiServices.get(url);
      final List<dynamic> decodedResponse = jsonDecode(response);

      final List<ProductCardModel> data =
          decodedResponse.map((productCardData) {
        return ProductCardModel.fromMap(
            productCardData as Map<String, dynamic>);
      }).toList();

      setPricesAndQuantitiesMap(data);

      setState(() {
        productCards.value = data;
      });
    } else {
      productCards.value = [];
    }
  }

  // It will create a field in the object with the id of the product, inserting its price and quantity
  void setPricesAndQuantitiesMap(List<ProductCardModel> productCards) {
    addPriceAndQuantityMap(productCards);
    removePricesAndQuantitiesMap();

    setTotalOrderPrice();
  }

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

  // If the quantity is one, the product is withdrawn, otherwise it is added or updated.
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

    setTotalOrderPrice();
  }

  void removePricesAndQuantitiesMap() {
    final List<String> cartProductIds =
        UserPreferencesInherited.of(context)!.cartProductIds;
    final List<String> mapKeys = pricesAndQuantitiesMap.keys.toList();

    for (String key in mapKeys) {
      if (!cartProductIds.contains(key)) {
        pricesAndQuantitiesMap.remove(key);
      }
    }
  }

  void removePriceAndQuantityMap(String productId) {
    pricesAndQuantitiesMap.remove(productId);

    setTotalOrderPrice();
  }

  // The calculation is made to define the total price of the products in the cart
  void setTotalOrderPrice() {
    double newTotalOrderPrice = 0;
    pricesAndQuantitiesMap.forEach((key, priceAndQuantityMap) {
      newTotalOrderPrice +=
          priceAndQuantityMap.price * priceAndQuantityMap.quantity;
    });

    setState(() {
      totalOrderPrice = newTotalOrderPrice;
    });
  }

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(
        title: "Carrinho",
        actionIcon: Icons.remove_circle_outline,
        actionIconTooltip: "Remover tudo",
        actionIconFunction: removeAllProducts,
        scaffoldKey: _scaffoldKey,
      ),
      body: ValueListenableBuilder(
        valueListenable: productCards,
        builder: (context, value, child) {
          if (value == null) {
            return const CircularProgressIndicator();
          } else if (value.isEmpty) {
            return const FeedbackWidget(
              message: "Ainda não há produtos no carrinho.",
            );
          }

          return CartScreenInherited(
            totalOrderPrice: totalOrderPrice,
            pricesAndQuantitiesMap: pricesAndQuantitiesMap,
            updatePricesAndQuantitiesMap: updatePricesAndQuantitiesMap,
            removePriceAndQuantityMap: removePriceAndQuantityMap,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const AppBarBreakWidget(),
                  ...value.map((productCard) {
                    return CartProductCardWidget(
                      key: ValueKey(productCard.id),
                      productCard: productCard,
                    );
                  }).toList(),
                  const SectionPriceOptionsWidget(),
                ],
              ),
            ),
          );
        },
      ),
      drawer: const DrawerWidget(),
    );
  }
}
