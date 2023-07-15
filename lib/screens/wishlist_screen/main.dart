import 'package:flutter/material.dart';
import "dart:developer" as developer;
import 'dart:convert';

import 'package:power_tech/models/product_card_model.dart';
import 'package:power_tech/models/products_card_navigation_model.dart';
import 'package:power_tech/providers/user_preferences_inherited.dart';

import 'package:power_tech/widgets/product_card_widget/main.dart';

import 'package:power_tech/services/api_services.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final APIServices apiServices = APIServices();
  final ValueNotifier<ProductsCardNavigationModel?> productsCardNavigation =
      ValueNotifier<ProductsCardNavigationModel?>(null);
  late final List<ProductCardModel> wishlistProducts;

  Future<void> fetchData(int skip) async {
    final List<String>? productIds =
        UserPreferencesInherited.of(context)?.wishlistProductIds;
    if (productIds == null || productIds.isEmpty) {
      return;
    }

    try {
      final String url =
          "wishlist-products?skip=$skip&productIds=${productIds.join(",")}";
      var result = await apiServices.get(url);
      Map<String, dynamic> data = jsonDecode(result);

      final ProductsCardNavigationModel productsCardNavigationData =
          ProductsCardNavigationModel.fromMap(data);

      final ProductsCardNavigationModel newProductsCardNavigation =
          ProductsCardNavigationModel(
        skip: productsCardNavigationData.skip,
        take: productsCardNavigationData.take,
        productsCard: productsCardNavigationData.productsCard,
      );

      setState(() {
        productsCardNavigation.value = newProductsCardNavigation;
      });
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
    fetchData(0);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: productsCardNavigation,
      builder: (context, value, child) {
        if (value == null) {
          return const CircularProgressIndicator();
        }

        return SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 10,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.spaceBetween,
                    children: List.generate(value.productsCard.length, (index) {
                      return ProductCardWidget(
                        productCard: value.productsCard[index],
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
