import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:power_tech/managers/prices_and_quantities_map_manager.dart';

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
    final PricesAndQuantitiesMapManager pricesAndQuantitiesMapManager =
        PricesAndQuantitiesMapManager(
      pricesAndQuantitiesMap: pricesAndQuantitiesMap,
      context: context,
    );

    pricesAndQuantitiesMapManager.addPriceAndQuantityMap(productCards);
    pricesAndQuantitiesMapManager.removePriceAndQuantityMap();

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final PricesAndQuantitiesMapManager pricesAndQuantitiesMapManager =
        PricesAndQuantitiesMapManager(
      pricesAndQuantitiesMap: pricesAndQuantitiesMap,
      setTotalOrderPrice: setTotalOrderPrice,
      context: context,
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(
        title: "Carrinho",
        actionIcon: Icons.remove_circle_outline,
        actionIconTooltip: "Remover tudo",
        actionIconFunction: pricesAndQuantitiesMapManager.removeAllProducts,
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
            updatePricesAndQuantitiesMap:
                pricesAndQuantitiesMapManager.updatePricesAndQuantitiesMap,
            removePriceAndQuantityMap:
                pricesAndQuantitiesMapManager.removePriceAndQuantityMapById,
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
