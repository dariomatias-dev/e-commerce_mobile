import 'package:flutter/material.dart';
import 'package:power_tech/models/price_and_quantity_model.dart';
import 'dart:convert';

import 'package:power_tech/models/product_card_model.dart';
import 'package:power_tech/providers/cart_screen_inherited.dart';

import 'package:power_tech/providers/user_preferences_inherited.dart';

import 'package:power_tech/screens/cart_screen/components/card_product_widget/main.dart';
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
  String totalPrice = "";

  Future<void> fecthData() async {
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

      setState(() {
        productCards.value = data;
      });
    } else {
      productCards.value = [];
    }
  }

  void updatePricesAndQuantitiesMap(
    String productId,
    double price,
    int quantity,
  ) {
    pricesAndQuantitiesMap[productId] = PriceAndQuantityModel(
      price: price,
      quantity: quantity,
    );

    setTotalPrice();
  }

  void setTotalPrice() {
    double totalOrderPrice = 0;
    pricesAndQuantitiesMap.forEach((key, priceAndQuantityMap) {
      totalOrderPrice +=
          priceAndQuantityMap.price * priceAndQuantityMap.quantity;
    });

    print(totalOrderPrice);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fecthData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(
        title: "Carrinho",
        actionIcon: Icons.remove_circle_outline,
        actionIconTooltip: "Remover tudo",
        actionIconFunction: () {},
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

          pricesAndQuantitiesMap = {};
          for (ProductCardModel productCard in value) {
            pricesAndQuantitiesMap[productCard.id] = PriceAndQuantityModel(
              price: productCard.price,
              quantity: 1,
            );
          }
          setTotalPrice();

          return Column(
            children: [
              const AppBarBreakWidget(),
              Expanded(
                child: CartScreenInherited(
                  totalPrice: totalPrice,
                  updatePricesAndQuantitiesMap: updatePricesAndQuantitiesMap,
                  child: ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      final ProductCardModel productCard = value[index];

                      return CartProductCardWidget(
                        productCard: productCard,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      drawer: const DrawerWidget(),
    );
  }
}
