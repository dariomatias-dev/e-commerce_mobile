import 'package:flutter/material.dart';
import "dart:developer" as developer;
import 'dart:convert';

import 'package:power_tech/models/product_card_model.dart';
import 'package:power_tech/models/products_card_navigation_model.dart';

import 'package:power_tech/providers/user_preferences_inherited.dart';

import 'package:power_tech/screens/main_screen/components/drawer_widget/main.dart';

import 'package:power_tech/widgets/app_bar_break_widget.dart';
import 'package:power_tech/widgets/custom_app_bar_widget/main.dart';
import 'package:power_tech/widgets/product_card_widget.dart';

import 'package:power_tech/services/api_services.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final APIServices apiServices = APIServices();

  final ValueNotifier<ProductsCardNavigationModel?> productsCardNavigation =
      ValueNotifier<ProductsCardNavigationModel?>(null);
  late final List<ProductCardModel> wishlistProducts;

  Future<void> fetchData(int skip) async {
    final List<String>? productIds =
        UserPreferencesInherited.of(context)?.wishlistProductIds;
    if (productIds == null) {
      return;
    } else if (productIds.isEmpty) {
      productsCardNavigation.value = ProductsCardNavigationModel(
        skip: 0,
        take: 0,
        productsCard: [],
      );
      return;
    }

    try {
      final String url =
          "products-by-ids?skip=$skip&productIds=${productIds.join(",")}";
      var result = await apiServices.get(url);
      final Map<String, dynamic> data = jsonDecode(result);

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
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(
        title: "Lista de desejos",
        actionIcon: Icons.search,
        actionIconTooltip: "Pesquisar",
        actionIconFunction: () {},
        scaffoldKey: _scaffoldKey,
      ),
      body: ValueListenableBuilder(
        valueListenable: productsCardNavigation,
        builder: (context, value, child) {
          if (value == null) {
            return const CircularProgressIndicator();
          } else if (value.productsCard.isEmpty) {
            return const Center(
              child: Text(
                "Lista de desejos vazia.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const AppBarBreakWidget(),
                  Align(
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
                            children: List.generate(
                              value.productsCard.length,
                              (index) {
                                return ProductCardWidget(
                                  productCard: value.productsCard[index],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
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
