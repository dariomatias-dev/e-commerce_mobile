import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'dart:convert';

import 'package:power_tech/models/products_card_navigation_model.dart';
import 'package:power_tech/screens/home_screen/section_products/filter_selector_widget.dart';
import 'package:power_tech/screens/home_screen/section_products/products_widget.dart';

import 'package:power_tech/services/api_services.dart';

class SectionProducts extends StatefulWidget {
  const SectionProducts({super.key});

  @override
  State<SectionProducts> createState() => _SectionProductsState();
}

class _SectionProductsState extends State<SectionProducts> {
  final APIServices apiServices = APIServices();
  final ValueNotifier<ProductsCardNavigationModel?> productsCardNavigation =
      ValueNotifier<ProductsCardNavigationModel?>(null);
  int amountOfProducts = 0;
  bool enableLoadMoreButton = true;

  @override
  void initState() {
    super.initState();
    initFecths();
  }

  Future<void> initFecths() async {
    await getAmountOfProducts();
    fetchData(0);
  }

  Future<void> getAmountOfProducts() async {
    try {
      var data = await apiServices.fetchData("products-amount");
      amountOfProducts = jsonDecode(data);
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  Future<void> fetchData(int skip) async {
    try {
      var result = await apiServices.fetchData("products?skip=$skip");
      Map<String, dynamic> data = jsonDecode(result);

      ProductsCardNavigationModel productsCardNavigationData =
          ProductsCardNavigationModel.fromMap(data);
      setState(() {
        productsCardNavigation.value = productsCardNavigationData;
        enableLoadMoreButton =
            !(productsCardNavigationData.skip >= amountOfProducts);
      });
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Produtos",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FilterSelectorWidget(),
            ],
          ),
        ),
        const SizedBox(height: 2),
        ValueListenableBuilder(
          valueListenable: productsCardNavigation,
          builder: (context, value, child) {
            if (value == null) {
              return const CircularProgressIndicator();
            }

            return ProductsWidget(
              productsCard: value.productsCard,
            );
          },
        ),
      ],
    );
  }
}
